import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shareed_todo/core/constants/app_decoration.dart';
import 'package:shareed_todo/core/widgets/custom_loader.dart';

import '../constants/app_style.dart';
import '../constants/color_constants.dart';
import 'custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      this.onTap,
      this.child,
      this.text = "",
      this.alignment,
      this.autofocus = false,
      this.isExpanded = true,
      this.backgroundColor,
      this.borderColor,
      this.borderRadius,
      this.animationDuration,
      this.borderWidth,
      this.elevation,
      this.padding,
      this.isLoading = false,
      this.textStyle,
      this.loadingText});
  final String text;
  final Widget? child;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final bool autofocus;
  final Color? backgroundColor;
  final Color? borderColor;
  final AlignmentGeometry? alignment;
  final double? elevation;
  final double? borderWidth;
  final bool isExpanded;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Duration? animationDuration;
  final bool isLoading;
  final String? loadingText;
  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: onTap,
                    autofocus: autofocus,
                    style: TextButton.styleFrom(
                      disabledBackgroundColor:
                          backgroundColor?.withValues(alpha: .5),
                      // maximumSize: Size(double.maxFinite, 40.h),
                      backgroundColor: backgroundColor,
                      alignment: alignment,
                      elevation: elevation == null ? null : (elevation),
                      padding: padding ??
                          EdgeInsets.symmetric(horizontal: 24.w, vertical: 9.h),
                      shape: borderRadius == null
                          ? RoundedRectangleBorder(
                              borderRadius: BorderRadiusStyle.roundedBorder8,
                            )
                          : RoundedRectangleBorder(
                              borderRadius: borderRadius!,
                            ),
                      animationDuration: animationDuration,

                      // enableFeedback:
                    ),
                    child: isLoading
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularLoader(
                                color: AppColors.white,
                                radius: 16.r,
                              ),
                              if (loadingText != null) ...[
                                SizedBox(width: 4.w),
                                CustomText(
                                  loadingText!,
                                  style: textStyle ??
                                      AppStyle.s18medium
                                          .copyWith(color: AppColors.white),
                                ),
                              ]
                            ],
                          )
                        : child ??
                            CustomText(
                              text,
                              style: textStyle ??
                                  AppStyle.s18medium
                                      .copyWith(color: AppColors.white),
                            )),
              ),
            ],
          )
        : ElevatedButton(
            onPressed: onTap,
            autofocus: autofocus,
            style: TextButton.styleFrom(
              // maximumSize: Size(double.maxFinite, 40.h),
              backgroundColor: backgroundColor,
              alignment: alignment,
              elevation: elevation == null ? null : (elevation),
              padding: padding ??
                  EdgeInsets.symmetric(horizontal: 24.w, vertical: 9.h),

              shape: borderRadius == null
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadiusStyle.roundedBorder8,
                    )
                  : RoundedRectangleBorder(
                      borderRadius: borderRadius!,
                    ),
              animationDuration: animationDuration,
              // enableFeedback:
            ),
            child: isLoading
                ? CircularLoader(
                    color: AppColors.white,
                    radius: 16.r,
                  )
                : child ??
                    CustomText(
                      text,
                      style: textStyle ??
                          AppStyle.s18medium.copyWith(color: AppColors.white),
                    ));
  }
}

class CustomElevatedButtonWithIcon extends StatelessWidget {
  const CustomElevatedButtonWithIcon(
      {super.key,
      this.onTap,
      this.text = "",
      this.alignment,
      this.autofocus = false,
      this.isTextCenter = true,
      this.backgroundColor,
      this.borderColor,
      this.borderRadius,
      this.borderWidth,
      this.animationDuration,
      this.elevation,
      this.padding,
      this.textStyle,
      this.suffixWidget,
      this.isExpanded = true,
      this.prefixWidget});
  final String text;

  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final bool autofocus;
  final bool isExpanded;
  final Color? backgroundColor;
  final Color? borderColor;
  final AlignmentGeometry? alignment;
  final double? elevation;
  final double? borderWidth;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isTextCenter;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final Duration? animationDuration;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      autofocus: autofocus,
      style: TextButton.styleFrom(
        // maximumSize: Size(double.maxFinite, 40.h),
        backgroundColor: backgroundColor ?? AppColors.brandPrimaryDefault,
        alignment: alignment,
        elevation: elevation,
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 24.w, vertical: 9.h),
        textStyle: textStyle,
        shape: borderRadius == null
            ? RoundedRectangleBorder(
                borderRadius: BorderRadiusStyle.roundedBorder8,
              )
            : RoundedRectangleBorder(
                borderRadius: borderRadius!,
              ),
        animationDuration: animationDuration,
        // enableFeedback:
      ),
      child: _buildButtonWithOrWithoutIcon(isExpanded),
    );
  }

  _buildButtonWithOrWithoutIcon(bool isExpanded) {
    return Row(
      mainAxisAlignment: isExpanded
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      mainAxisSize: isExpanded ? MainAxisSize.min : MainAxisSize.max,
      children: [
        if (prefixWidget != null) prefixWidget!,
        if (isTextCenter) const SizedBox(),
        Center(
          child: CustomText(
            text,
            style: textStyle ??
                AppStyle.s18medium.copyWith(color: AppColors.white),
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        if (prefixWidget == null)
          suffixWidget ??
              const Icon(
                Icons.chevron_right,
                color: AppColors.white,
              ),
      ],
    );
  }
}
