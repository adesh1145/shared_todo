import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shareed_todo/core/constants/app_decoration.dart';
import 'package:shareed_todo/core/widgets/custom_button.dart';
import 'package:shareed_todo/core/widgets/custom_snackbar.dart';
import 'package:shareed_todo/core/widgets/custom_text_form_field.dart';
import 'package:shareed_todo/presentation/model/todo.dart';
import 'package:shareed_todo/presentation/view_model/todo_provider.dart';

import '../../core/constants/app_images.dart';
import '../../core/constants/app_style.dart';
import '../../core/constants/color_constants.dart';
import '../../core/widgets/custom_image_view.dart';
import '../../core/widgets/custom_text.dart';
import '../model/user_detail.dart';

class TodoDetail extends StatefulWidget {
  TodoDetail({super.key, required this.todoId});
  String? todoId;

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  Timer? _debounce;
  @override
  void initState() {
    super.initState();
  }

  void _onTextChanged(TodoProvider provider) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(Duration(seconds: 1), () {
      _saveText(provider);
    });
  }

  void _saveText(TodoProvider provider) {
    if (widget.todoId == null) {
      print("Saving New");
      provider
          .createTodo(
        titleController.text,
        descController.text,
      )
          .then(
        (value) {
          value.fold((l) {
            customSnackBar(l, msgType: MsgType.error);
          }, (r) {
            widget.todoId = r;
          });
        },
      );
    } else {
      print(descController.text);
      provider
          .updateTodo(
        widget.todoId!,
        titleController.text,
        descController.text,
      )
          .then((value) {
        value.fold((l) {
          customSnackBar(l, msgType: MsgType.error);
        }, (r) {});
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(builder: (context, provider, child) {
      return StreamBuilder<Todo>(
          stream: widget.todoId != null
              ? provider.getTodoByIdRealtime(widget.todoId!)
              : null,
          builder: (context, snapshot) {
            final todo = snapshot.data;
            if (snapshot.hasData && todo != null) {
              if (titleController.text != todo.title) {
                titleController.text = todo.title;
              }
              if (descController.text != todo.description) {
                descController.text = todo.description;
              }
            }
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      size: 30.r,
                    )),
                title: CustomText(
                  provider.isLoading ? "Saving..." : "Saved",
                  style: AppStyle.s12regular
                      .copyWith(color: AppColors.neutralGhost),
                ),
                actions: [
                  CustomElevatedButton(
                    isExpanded: false,
                    text: "Share",
                    onTap: () {
                      shareDialog(todo!);
                    },
                    borderRadius: BorderRadiusStyle.roundedBorder23,
                    backgroundColor: AppColors.brandPrimaryDefault,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  ),
                  SizedBox(
                    width: 16.w,
                  )
                ],
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      maxLines: 1,
                      cursorColor: AppColors.brandPrimaryDefault,
                      textInputAction: TextInputAction.next,
                      style: AppStyle.s18bold
                          .copyWith(color: AppColors.brandPrimaryDefault),
                      onChanged: (value) {
                        _onTextChanged(provider);
                      },
                      decoration: InputDecoration(
                          hintText: "eg : Meeting with client",
                          hintStyle: AppStyle.s16regular
                              .copyWith(color: AppColors.neutralGhost),
                          border: InputBorder.none),
                    ),
                    Expanded(
                      child: TextField(
                        controller: descController,
                        maxLines: 100,
                        cursorColor: AppColors.neutralSecondary,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          _onTextChanged(provider);
                        },
                        style: AppStyle.s16medium
                            .copyWith(color: AppColors.neutralSecondary),
                        decoration: InputDecoration(
                            hintText: "eg : Meeting with client",
                            hintStyle: AppStyle.s16regular
                                .copyWith(color: AppColors.neutralGhost),
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }

  void shareDialog(Todo todo) {
    showDialog(
      context: context,
      builder: (context) {
        return ShareDialogWidget(todo: todo);
      },
    );
  }
}

class ShareDialogWidget extends StatefulWidget {
  const ShareDialogWidget({
    super.key,
    required this.todo,
  });
  final Todo todo;
  @override
  State<ShareDialogWidget> createState() => _ShareDialogWidgetState();
}

class _ShareDialogWidgetState extends State<ShareDialogWidget> {
  UserDetail? ownerDetail;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<TodoProvider>(context, listen: false);
      provider.getOwnerDetail(widget.todo.ownerId);
      provider.getUsersByIds(widget.todo.sharedWith);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.roundedBorder23,
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.neutralGhost,
              blurRadius: 10.r,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: SizedBox(
          height: 200.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                "Share",
                style: AppStyle.s18bold
                    .copyWith(color: AppColors.brandPrimaryDefault),
              ),
              SizedBox(height: 16.h),
              CustomText(
                "Share this todo with your friends",
                style: AppStyle.s16regular
                    .copyWith(color: AppColors.neutralSecondary),
              ),
              SizedBox(height: 16.h),
              Autocomplete<UserDetail>(
                displayStringForOption: (UserDetail option) =>
                    option.name ?? '',
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<UserDetail>.empty();
                  }
                  final provider =
                      Provider.of<TodoProvider>(context, listen: false);
                  await provider.searchUsers(textEditingValue.text);
                  return provider.searchedUsers;
                },
                onSelected: (UserDetail selection) {
                  final provider =
                      Provider.of<TodoProvider>(context, listen: false);
                  provider.shareTodo(widget.todo.todoId, selection);
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return CustomTextFormField(
                    hintText: "Search user",
                    focusNode: focusNode,
                    controller: textEditingController,
                    onChanged: (value) async {
                      final provider =
                          Provider.of<TodoProvider>(context, listen: false);

                      onFieldSubmitted();
                    },
                    keyboardType: TextInputType.emailAddress,
                  );
                },
                optionsViewBuilder: (context, onSelected, options) {
                  return Material(
                    elevation: 4.0,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final UserDetail option = options.elementAt(index);
                        return ListTile(
                          leading: option.photoUrl == null
                              ? CircleAvatar(
                                  radius: 20.r,
                                  child:
                                      Text(option.name?.substring(0, 1) ?? ''),
                                )
                              : CustomImageView(
                                  height: 40.h,
                                  width: 40.w,
                                  radius: BorderRadius.circular(20.r),
                                  url: option.photoUrl,
                                ),
                          title: Text(option.name ?? ''),
                          subtitle: Text(option.email ?? ''),
                          onTap: () {
                            onSelected(option);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),
              CustomText("Owner",
                  style: AppStyle.s18bold
                      .copyWith(color: AppColors.brandPrimaryDefault)),
              Consumer<TodoProvider>(builder: (context, provider, child) {
                return ListTile(
                  leading: ownerDetail?.photoUrl == null
                      ? CircleAvatar(
                          radius: 20.r,
                          child: Text(ownerDetail?.name?.substring(0, 1) ?? ''),
                        )
                      : CustomImageView(
                          height: 40.h,
                          width: 40.w,
                          radius: BorderRadius.circular(20.r),
                          url: ownerDetail?.photoUrl,
                        ),
                  title: Text(ownerDetail?.name ?? ''),
                  subtitle: Text(ownerDetail?.email ?? ''),
                );
              }),
              CustomText("Shared With",
                  style: AppStyle.s18bold
                      .copyWith(color: AppColors.brandPrimaryDefault)),
              Consumer<TodoProvider>(builder: (context, provider, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.sharedUsers.length,
                  itemBuilder: (context, index) {
                    final user = provider.sharedUsers[index];
                    return ListTile(
                      leading: user.photoUrl == null
                          ? CircleAvatar(
                              radius: 20.r,
                              child: Text(user.name?.substring(0, 1) ?? ''),
                            )
                          : CustomImageView(
                              height: 40.h,
                              width: 40.w,
                              radius: BorderRadius.circular(20.r),
                              url: user.photoUrl,
                            ),
                      title: Text(user.name ?? ''),
                      subtitle: Text(user.email ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete,
                            color: AppColors.brandPrimaryDefault),
                        onPressed: () {
                          Provider.of<TodoProvider>(context, listen: false)
                              .removeSharedUser(widget.todo.todoId, user);
                        },
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
