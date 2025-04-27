import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_style.dart';
import '../constants/color_constants.dart';

class CustomTextFormField2 extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextInputType keyboardType;
  // final bool obscureText;
  final bool isPassword;
  final bool readOnly;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final Color? fillColor;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? borderRadius;
  final double borderWidth;
  final Color? enabledBorderColor;
  final Color? disableBorderColor;
  final Color? focusBorderColor;
  final Color? errorBorderColor;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLine;
  final int? minLine;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  bool isvisible = false;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final Widget? prefix;
  final String? prefixText;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final InputBorder? border;
  final InputBorder? focusBorder;
  final InputBorder? enableBorder;
  CustomTextFormField2(
      {super.key,
      this.hintText,
      this.labelText,
      this.isPassword = false,
      this.keyboardType = TextInputType.text,
      this.enabledBorderColor,
      this.disableBorderColor,
      this.focusBorderColor,
      this.errorBorderColor,
      this.textStyle,
      // this.obscureText = false,
      this.borderWidth = 1.0,
      this.floatingLabelBehavior,
      this.controller,
      this.contentPadding,
      this.borderRadius,
      this.prefixIcon,
      this.suffixIcon,
      this.fillColor,
      this.inputFormatters,
      this.onTap,
      this.onChanged,
      this.maxLength,
      this.maxLine,
      this.textCapitalization = TextCapitalization.none,
      this.minLine,
      this.textInputAction,
      this.onEditingComplete,
      this.suffixIconConstraints,
      this.prefixIconConstraints,
      this.validator,
      this.prefix,
      this.prefixText,
      this.textAlign,
      this.focusNode,
      this.border,
      this.enableBorder,
      this.focusBorder,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    isvisible = isPassword;
    return TextFormField(
      validator: validator,
      keyboardType: keyboardType,
      obscureText: isvisible,
      style: textStyle ?? AppStyle.s14medium,
      focusNode: focusNode,
      textAlign: textAlign ?? TextAlign.start,
      // AppStyle.roboto14w500,
      controller: controller,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      minLines: maxLine,
      maxLines: maxLine ?? 1,
      onChanged: onChanged,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      readOnly: readOnly,
      textInputAction: textInputAction ?? TextInputAction.done,
      textCapitalization: textCapitalization,
      cursorColor: textStyle?.color ?? AppColors.brandPrimaryDefault,
      decoration: InputDecoration(
        fillColor: fillColor ?? AppColors.white.withValues(alpha: 0.03),
        filled: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        hintText: hintText,
        hintStyle: textStyle ?? AppStyle.s14medium,
        labelText: labelText,
        labelStyle: textStyle ?? AppStyle.s14medium,

        enabledBorder: enableBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid,
                  width: borderWidth,
                  color: enabledBorderColor ??
                      AppColors.brandPrimaryDefault.withValues(alpha: 0.15)),
              borderRadius: borderRadius ?? BorderRadius.circular(10.r),
            ),
        focusedBorder: focusBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid,
                  width: borderWidth,
                  color: focusBorderColor ??
                      AppColors.brandPrimaryDefault.withValues(alpha: 0.15)),
              borderRadius: borderRadius ?? BorderRadius.circular(10.r),
            ),
        // disabledBorder: enabledBorderColor == null
        //     ? null
        //     : OutlineInputBorder(
        //         borderSide:
        //             BorderSide(width: borderWidth, color: disableBorderColor!),
        //         borderRadius: borderRadius ?? BorderRadius.circular(10.r),
        //       ),
        border: border ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid,
                  width: borderWidth,
                  color: AppColors.brandPrimaryDefault.withValues(alpha: 0.15)),
              borderRadius: borderRadius ?? BorderRadius.circular(10.r),
            ),

        errorBorder: errorBorderColor == null
            ? null
            : UnderlineInputBorder(
                borderSide: BorderSide(
                    style: BorderStyle.solid,
                    width: borderWidth,
                    color: errorBorderColor!),
                borderRadius: borderRadius ?? BorderRadius.circular(10.r),
              ),
        floatingLabelBehavior:
            floatingLabelBehavior ?? FloatingLabelBehavior.auto,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 10.w),
          child: prefixIcon,
        ),
        suffixIconConstraints: suffixIconConstraints ??
            BoxConstraints(minHeight: 17.h, maxHeight: 30.h),
        prefixIconConstraints: prefixIconConstraints ??
            BoxConstraints(minHeight: 17.h, maxHeight: 30.h),
        prefix: prefix,
        prefixText: prefixText,
        suffixIcon: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 10.w),
          child: isPassword
              ? IconButton(
                  onPressed: () {
                    // isvisible.value = !isvisible.value;
                  },
                  icon: isvisible
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility))
              : suffixIcon,
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextInputType keyboardType;
  // final bool obscureText;
  final bool isPassword;
  final bool readOnly;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final Color? fillColor;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? borderRadius;
  final double borderWidth;
  final Color? enabledBorderColor;
  final Color? disableBorderColor;
  final Color? focusBorderColor;
  final Color? errorBorderColor;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLine;
  final int? minLine;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  bool isvisible = false;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final Widget? prefix;
  final String? prefixText;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final Color? shadowColor;
  final BoxDecoration? decoration;
  CustomTextFormField(
      {super.key,
      this.hintText,
      this.labelText,
      this.isPassword = false,
      this.keyboardType = TextInputType.text,
      this.enabledBorderColor,
      this.disableBorderColor,
      this.focusBorderColor,
      this.errorBorderColor,
      this.textStyle,
      // this.obscureText = false,
      this.borderWidth = 1.0,
      this.floatingLabelBehavior,
      this.controller,
      this.contentPadding,
      this.borderRadius,
      this.prefixIcon,
      this.suffixIcon,
      this.fillColor,
      this.inputFormatters,
      this.onTap,
      this.onChanged,
      this.maxLength,
      this.maxLine,
      this.textCapitalization = TextCapitalization.none,
      this.minLine,
      this.textInputAction,
      this.onEditingComplete,
      this.suffixIconConstraints,
      this.prefixIconConstraints,
      this.validator,
      this.prefix,
      this.prefixText,
      this.textAlign,
      this.focusNode,
      this.readOnly = false,
      this.shadowColor,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    isvisible = isPassword;
    return Container(
      decoration: decoration ??
          BoxDecoration(boxShadow: [
            BoxShadow(
                color: shadowColor ??
                    AppColors.neutralPrimary.withValues(alpha: 0.08),
                // offset: const Offset(0, 4), // Shadow position
                blurRadius: 15.r,
                spreadRadius: 1)
          ]),
      child: TextFormField(
        validator: validator,
        keyboardType: keyboardType,
        obscureText: isvisible,
        style: textStyle ?? AppStyle.s14medium,
        focusNode: focusNode,
        textAlign: textAlign ?? TextAlign.start,
        // AppStyle.roboto14w500,
        controller: controller,
        inputFormatters: inputFormatters,
        minLines: maxLine,
        maxLines: maxLine,
        onChanged: onChanged,
        cursorColor: textStyle?.color ?? AppColors.brandPrimaryDefault,
        onTap: onTap,
        onEditingComplete: onEditingComplete,
        readOnly: readOnly,
        textInputAction: textInputAction ?? TextInputAction.done,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          fillColor: fillColor ?? AppColors.white,
          filled: true,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          hintText: hintText,
          hintStyle: textStyle ?? AppStyle.s14medium,
          labelText: labelText,
          hintMaxLines: 3,
          labelStyle: textStyle ?? AppStyle.s14medium,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                style: BorderStyle.solid,
                width: borderWidth,
                color: enabledBorderColor ??
                    AppColors.brandPrimaryDefault.withValues(alpha: 0.15)),
            borderRadius: borderRadius ?? BorderRadius.circular(10.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                style: BorderStyle.solid,
                width: borderWidth,
                color: focusBorderColor ??
                    AppColors.brandPrimaryDefault.withValues(alpha: 0.15)),
            borderRadius: borderRadius ?? BorderRadius.circular(10.r),
          ),
          // disabledBorder: enabledBorderColor == null
          //     ? null
          //     : OutlineInputBorder(
          //         borderSide:
          //             BorderSide(width: borderWidth, color: disableBorderColor!),
          //         borderRadius: borderRadius ?? BorderRadius.circular(10.r),
          //       ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                style: BorderStyle.solid,
                width: borderWidth,
                color: AppColors.brandPrimaryDefault.withValues(alpha: 0.15)),
            borderRadius: borderRadius ?? BorderRadius.circular(10.r),
          ),

          errorBorder: errorBorderColor == null
              ? null
              : OutlineInputBorder(
                  borderSide: BorderSide(
                      style: BorderStyle.solid,
                      width: borderWidth,
                      color: errorBorderColor!),
                  borderRadius: borderRadius ?? BorderRadius.circular(10.r),
                ),
          errorStyle:
              AppStyle.s12regular.copyWith(color: AppColors.errorDefault),

          floatingLabelBehavior:
              floatingLabelBehavior ?? FloatingLabelBehavior.auto,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 10.w),
            child: prefixIcon,
          ),
          suffixIconConstraints: suffixIconConstraints ??
              BoxConstraints(minHeight: 17.h, maxHeight: 30.h),
          prefixIconConstraints: prefixIconConstraints ??
              BoxConstraints(minHeight: 17.h, maxHeight: 30.h),
          prefix: prefix,
          prefixText: prefixText,
          suffixIcon: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 10.w),
            child: isPassword
                ? IconButton(
                    onPressed: () {
                      // isvisible.value = !isvisible.value;
                    },
                    icon: isvisible
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility))
                : suffixIcon,
          ),
        ),
      ),
    );
  }
}
