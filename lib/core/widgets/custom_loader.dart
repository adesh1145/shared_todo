import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({
    super.key,
    this.radius,
    this.color,
    this.strokeWidth,
  });
  final double? radius;
  final double? strokeWidth;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: radius,
        width: radius,
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth ?? 4,
            color: color ?? AppColors.brandPrimaryDefault,
          ),
        ));
  }
}
