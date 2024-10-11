import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_quote_generator/global/generated/fonts.gen.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextStyle displayLarge = TextStyle(
    fontSize: 44.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle displayMedium = TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle displaySmall = TextStyle(
    fontSize: 36.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle headlineLarge = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle headlineMedium = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle headlineSmall = TextStyle(
    fontSize: 26.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle titleLarge = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle titleMedium = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle titleSmall = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle bodyLarge = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle bodyMedium = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle bodySmall = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle molecules = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
  );
}

class AppTextThemeExtension extends ThemeExtension<AppTextThemeExtension> {
  const AppTextThemeExtension({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.molecules,
  });

  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle molecules;

  @override
  ThemeExtension<AppTextThemeExtension> copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? molecules,
  }) {
    return AppTextThemeExtension(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      molecules: molecules ?? this.molecules,
    );
  }

  @override
  ThemeExtension<AppTextThemeExtension> lerp(
    covariant ThemeExtension<AppTextThemeExtension>? other,
    double t,
  ) {
    if (other is! AppTextThemeExtension) {
      return this;
    }

    return AppTextThemeExtension(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t)!,
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      molecules: TextStyle.lerp(molecules, other.molecules, t)!,
    );
  }
}
