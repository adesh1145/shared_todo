import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shareed_todo/core/config/app_routes.dart';
import 'package:shareed_todo/core/constants/app_style.dart';
import 'package:shareed_todo/core/constants/color_constants.dart';
import 'package:shareed_todo/core/widgets/custom_image_view.dart';
import 'package:shareed_todo/core/widgets/custom_text.dart';

import '../../core/constants/app_images.dart';
import '../view_model/auth_provider.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        Provider.of<AuthProvider>(context, listen: false).isLogin()
            ? Navigator.pushReplacementNamed(context, AppRoutes.todoList)
            : Navigator.pushReplacementNamed(context, AppRoutes.socialLogin);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandPrimaryDefault,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImageView(
              svgPath: AppImages.splash,
              height: 68.h,
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomText(
              "Todo App",
              style: AppStyle.s26bold.copyWith(color: AppColors.white),
            ),
            SizedBox(
              height: 12.h,
            ),
            CustomText(
              "The best to do list application for you",
              textAlign: TextAlign.center,
              style: AppStyle.s14regular.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
