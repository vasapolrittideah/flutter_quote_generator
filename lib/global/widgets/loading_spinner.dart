import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_quote_generator/global/themes/app_color_theme.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({
    super.key,
    this.color = AppColorPalette.riceCake,
    this.size = 25,
    this.strokeWidth = 3,
  });

  final Color color;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.h,
      padding: EdgeInsets.all(2.r),
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth.sp,
        color: color,
      ),
    );
  }
}
