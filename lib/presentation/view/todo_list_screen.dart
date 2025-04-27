import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shareed_todo/core/config/app_routes.dart';
import 'package:shareed_todo/core/constants/app_decoration.dart';
import 'package:shareed_todo/core/constants/app_images.dart';
import 'package:shareed_todo/core/constants/app_style.dart';
import 'package:shareed_todo/core/constants/color_constants.dart';
import 'package:shareed_todo/core/utils/date_convertor.dart';
import 'package:shareed_todo/core/widgets/custom_image_view.dart';
import 'package:shareed_todo/core/widgets/custom_text.dart';
import 'package:shareed_todo/presentation/model/todo.dart';
import 'package:shareed_todo/presentation/view_model/auth_provider.dart';
import 'package:shareed_todo/presentation/view_model/todo_provider.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isShared = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          final user = authProvider.userDetail;
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.brandPrimaryDefault,
                ),
                accountName: Text(user?.name ?? '',
                    style:
                        AppStyle.s16semBold.copyWith(color: AppColors.white)),
                accountEmail: Text(user?.email ?? '',
                    style: AppStyle.s14medium.copyWith(color: AppColors.white)),
                currentAccountPicture: CustomImageView(
                  url: user?.photoUrl,
                  height: 100.r,
                  width: 100.r,
                  fit: BoxFit.fill,
                  radius: BorderRadius.circular(50.r),
                ),
              ),
              ListTile(
                title: Text('My Todos'),
                onTap: () {
                  setState(() {
                    isShared = false;
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                title: Text('Shared Todos'),
                onTap: () {
                  setState(() {
                    isShared = true;
                    Navigator.pop(context);
                  });
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout, color: AppColors.errorDefault),
                title: Text('Log Out'),
                onTap: () async {
                  authProvider.signOut();
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.socialLogin);
                },
              ),
              SizedBox(height: 20.h),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.brandPrimaryDefault,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.todoDetail, arguments: null);
        },
        child: Icon(Icons.add, color: AppColors.white),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150.h,
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: CustomText(isShared ? 'Shared Todos' : 'My Todos'),
            ),
          ),
          Consumer<TodoProvider>(builder: (context, provider, child) {
            return StreamBuilder<List<Todo>>(
                stream: provider.getTodos(isShared: isShared),
                builder: (context, snapshot) {
                  if (snapshot.data?.isEmpty ?? true) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text('No todos available'),
                      ),
                    );
                  }
                  final todos = snapshot.data!;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, int index) {
                        return card(todos[index]);
                      },
                      childCount: todos.length,
                    ),
                  );
                });
          }),
        ],
      ),
    );
  }

  Widget card(Todo todo) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.todoDetail,
              arguments: todo.todoId);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h, left: 16.w, right: 16.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder8,
              boxShadow: [
                BoxShadow(
                  color: Color(0x140F163A),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
              color: AppColors.white),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.r),
                        topRight: Radius.circular(8.r)),
                    color: AppColors.brandPrimaryDefault),
                // color: AppColors.brandPrimaryDefault,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusStyle.roundedBorder4,
                          color: AppColors.white),
                      child: Icon(
                        Icons.add,
                        color: AppColors.brandPrimaryDefault,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomText(
                        todo.title,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        style:
                            AppStyle.s18bold.copyWith(color: AppColors.white),
                        // maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Provider.of<TodoProvider>(context, listen: false)
                              .deleteTodo(todo.todoId);
                        },
                        icon: Icon(Icons.delete, color: AppColors.errorDark))
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      todo.description,
                      textAlign: TextAlign.left,
                      style: AppStyle.s14medium
                          .copyWith(color: AppColors.neutralGhost),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Divider(
                      color: AppColors.neutralGhost,
                    ),
                    Row(
                      children: [
                        CustomText(
                          "Created at: ${parsehhmmaaddmmmyyyy(todo.timestamp?.toDate() ?? DateTime.now())}",
                          style: AppStyle.s14medium
                              .copyWith(color: AppColors.neutralGhost),
                          maxLines: 5,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
