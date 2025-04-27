import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyle {
  static TextScaler get textScalfactor =>
      TextScaler.linear(ScreenUtil().textScaleFactor);
  static final _font = 'SFProDisplay';

  static TextStyle style(double size, FontWeight weight,
          [double? lineHeight]) =>
      TextStyle(
        fontSize: size,
        fontWeight: weight,
        height: lineHeight != null ? lineHeight / size : null,
        fontFamily: _font,
      );

  static TextStyle s28regular = TextStyle(
      fontSize: 28.sp, fontWeight: FontWeight.w400, fontFamily: _font);
  static TextStyle s28medium = TextStyle(
      fontSize: 28.sp, fontWeight: FontWeight.w500, fontFamily: _font);
  static TextStyle s28semBold = TextStyle(
      fontSize: 28.sp, fontWeight: FontWeight.w600, fontFamily: _font);
  static TextStyle s28bold = TextStyle(
      fontSize: 28.sp, fontWeight: FontWeight.w700, fontFamily: _font);

  static TextStyle s26regular = TextStyle(
      fontSize: 26.sp, fontWeight: FontWeight.w400, fontFamily: _font);
  static TextStyle s26medium = TextStyle(
      fontSize: 26.sp, fontWeight: FontWeight.w500, fontFamily: _font);
  static TextStyle s26semBold = TextStyle(
      fontSize: 26.sp, fontWeight: FontWeight.w600, fontFamily: _font);
  static TextStyle s26bold = TextStyle(
      fontSize: 26.sp, fontWeight: FontWeight.w700, fontFamily: _font);

  static TextStyle s24regular = TextStyle(
      fontSize: 24.sp, fontWeight: FontWeight.w400, fontFamily: _font);
  static TextStyle s24medium = TextStyle(
      fontSize: 24.sp, fontWeight: FontWeight.w500, fontFamily: _font);
  static TextStyle s24semBold = TextStyle(
      fontSize: 24.sp, fontWeight: FontWeight.w600, fontFamily: _font);
  static TextStyle s24bold = TextStyle(
      fontSize: 24.sp, fontWeight: FontWeight.w700, fontFamily: _font);

  static TextStyle s18regular = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w400, fontFamily: _font);
  static TextStyle s18medium = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w500, fontFamily: _font);
  static TextStyle s18semBold = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w600, fontFamily: _font);
  static TextStyle s18bold = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w700, fontFamily: _font);

  static TextStyle s16regular = TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.w400, fontFamily: _font);
  static TextStyle s16medium = TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: _font);
  static TextStyle s16semBold = TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.w600, fontFamily: _font);
  static TextStyle s16bold = TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.w700, fontFamily: _font);

  static TextStyle s14regular = TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.w400, fontFamily: _font);
  static TextStyle s14medium = TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.w500, fontFamily: _font);
  static TextStyle s14semBold = TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.w600, fontFamily: _font);
  static TextStyle s14bold = TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.w700, fontFamily: _font);

  static TextStyle s12regular = TextStyle(
      fontSize: 12.sp, fontWeight: FontWeight.w400, fontFamily: _font);
  static TextStyle s12medium = TextStyle(
      fontSize: 12.sp, fontWeight: FontWeight.w500, fontFamily: _font);
  static TextStyle s12semBold = TextStyle(
      fontSize: 12.sp, fontWeight: FontWeight.w600, fontFamily: _font);
  static TextStyle s12bold = TextStyle(
      fontSize: 12.sp, fontWeight: FontWeight.w700, fontFamily: _font);

  static TextStyle s10regular = TextStyle(
      fontSize: 10.sp, fontWeight: FontWeight.w400, fontFamily: _font);
  static TextStyle s10medium = TextStyle(
      fontSize: 10.sp, fontWeight: FontWeight.w500, fontFamily: _font);
  static TextStyle s10semBold = TextStyle(
      fontSize: 10.sp, fontWeight: FontWeight.w600, fontFamily: _font);
  static TextStyle s10bold = TextStyle(
      fontSize: 10.sp, fontWeight: FontWeight.w700, fontFamily: _font);
}
