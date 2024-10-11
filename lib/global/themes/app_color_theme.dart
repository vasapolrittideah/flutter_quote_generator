import 'package:flutter/material.dart';

class AppColorPalette {
  AppColorPalette._();

  static const Color codGrey = Color(0xFF181818);
  static const Color mineShaft = Color(0xFF282828);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color riceCake = Color(0xFFFFFEF1);
  static const Color cinnabar = Color(0xFFED4245);
  static const Color buttercup = Color(0xFFF2BD1D);
  static const Color blueChill = Color(0xFF118AB2);
  static const Color persianGreen = Color(0xFF01B985);
}

class AppColorThemeExtension extends ThemeExtension<AppColorThemeExtension> {
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color error;
  final Color onError;
  final Color success;
  final Color onSuccess;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;

  AppColorThemeExtension({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.error,
    required this.onError,
    required this.success,
    required this.onSuccess,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
  });

  @override
  ThemeExtension<AppColorThemeExtension> copyWith({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? error,
    Color? onError,
    Color? success,
    Color? onSuccess,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
  }) {
    return AppColorThemeExtension(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
    );
  }

  @override
  ThemeExtension<AppColorThemeExtension> lerp(
    covariant ThemeExtension<AppColorThemeExtension>? other,
    double t,
  ) {
    if (other is! AppColorThemeExtension) {
      return this;
    }

    return AppColorThemeExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
    );
  }
}
