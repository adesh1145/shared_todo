import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shareed_todo/core/constants/app_style.dart';

import '../constants/color_constants.dart';
import 'custom_text.dart';

void customSnackBar(String msg,
    {MsgType msgType = MsgType.success, BuildContext? context}) {
  if (context != null) {
    ScaffoldMessenger.of(context)
        .showSnackBar(appSnackBar(msg, msgType, context));
  } else {
    // If no context is provided, we can't use localization
    // Use a fallback approach with hardcoded strings
    // scaffoldMessengerKey.currentState?.showSnackBar(
    //   appSnackBar(msg, msgType, scaffoldMessengerKey.currentState!.context),
    // );
  }
}

SnackBar appSnackBar(String msg, MsgType msgType, BuildContext context) {
  return SnackBar(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    content: Row(
      children: [
        msgType == MsgType.success
            ? const Icon(
                Icons.check_circle_rounded,
                color: AppColors.successDefault,
              )
            : msgType == MsgType.error
                ? const Icon(
                    Icons.error_outline_rounded,
                    color: AppColors.errorDefault,
                  )
                : const Icon(
                    Icons.warning_amber_rounded,
                    color: AppColors.warningDefault,
                  ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomText(
                MsgType.success == msgType
                    ? 'Success'
                    : MsgType.warning == msgType
                        ? 'Warning'
                        : 'Error',
                style: AppStyle.s16bold,
              ),
              SizedBox(
                height: 6.h,
              ),
              CustomText(
                msg,
                maxLines: 3,
                textAlign: TextAlign.left,
                style: AppStyle.s14medium,
              ),
            ],
          ),
        ),
      ],
    ),
    backgroundColor: AppColors.brandPrimaryBackground,
    duration: const Duration(milliseconds: 2000),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    ),
  );
}

enum MsgType { error, warning, success }
