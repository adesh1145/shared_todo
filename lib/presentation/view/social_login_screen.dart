import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shareed_todo/core/config/app_routes.dart';
import 'package:shareed_todo/core/constants/app_decoration.dart';
import 'package:shareed_todo/core/constants/app_images.dart';
import 'package:shareed_todo/core/constants/app_style.dart';
import 'package:shareed_todo/core/constants/color_constants.dart';
import 'package:shareed_todo/core/widgets/custom_button.dart';
import 'package:shareed_todo/core/widgets/custom_image_view.dart';
import 'package:shareed_todo/core/widgets/custom_loader.dart';
import 'package:shareed_todo/core/widgets/custom_snackbar.dart';
import 'package:shareed_todo/core/widgets/custom_text.dart';

import '../view_model/auth_provider.dart';

class SocialLoginScreen extends StatefulWidget {
  const SocialLoginScreen({super.key});

  @override
  State<SocialLoginScreen> createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 76.h),
            RichText(
                text: TextSpan(
                    text: "Welcome to ",
                    style: AppStyle.s26semBold
                        .copyWith(color: AppColors.neutralPrimary),
                    children: [
                  TextSpan(
                    text: "TODO App",
                    style: AppStyle.s26semBold
                        .copyWith(color: AppColors.brandPrimaryDefault),
                  )
                ])),
            SizedBox(height: 68.h),
            CustomImageView(
              svgPath: AppImages.onboard3,
              width: 1.sw,
            ),
            SizedBox(height: 26.h),
            // Row(
            //   children: [
            //     Expanded(
            //       child: CustomElevatedButtonWithIcon(
            //         text: "Continue with Email",
            //         isExpanded: true,
            //         backgroundColor: AppColors.brandPrimaryDefault,
            //         borderRadius: BorderRadiusStyle.roundedBorder16,
            //         padding:
            //             EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            //         textStyle:
            //             AppStyle.s18medium.copyWith(color: AppColors.white),
            //         onTap: () {},
            //         prefixWidget: Padding(
            //           padding: EdgeInsets.only(right: 8.w),
            //           child: Icon(
            //             Icons.mail,
            //             color: AppColors.white,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 16.h),

            // Row(
            //   children: [
            //     Expanded(child: Divider(color: AppColors.neutralSecondary)),
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 16.w),
            //       child: CustomText(
            //         "or continue with",
            //         style: AppStyle.s12medium
            //             .copyWith(color: AppColors.neutralSecondary),
            //       ),
            //     ),
            //     Expanded(child: Divider(color: AppColors.neutralSecondary))
            //   ],
            // ),
            // SizedBox(height: 16.h),
            Row(children: [
              Expanded(
                child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                  return authProvider.isLoading
                      ? CircularLoader()
                      : CustomElevatedButtonWithIcon(
                          text: "Google",
                          isExpanded: true,
                          backgroundColor: Color(0xFFF3F5F9),
                          borderRadius: BorderRadiusStyle.roundedBorder16,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 15.h),
                          textStyle:
                              AppStyle.s18medium.copyWith(color: Colors.black),
                          onTap: () {
                            authProvider.signInWithGoogle().then(
                              (value) {
                                value.fold(
                                  (l) {
                                    customSnackBar(l, msgType: MsgType.error);
                                  },
                                  (r) {
                                    print(r.email);
                                    Navigator.pushReplacementNamed(
                                        context, AppRoutes.todoList);
                                  },
                                );
                              },
                            );
                          },
                          prefixWidget: Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: CustomImageView(
                              imagePath: AppImages.google,
                              height: 24.h,
                            ),
                          ),
                        );
                }),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
