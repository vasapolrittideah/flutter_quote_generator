import 'package:flutter/material.dart';

import 'package:flutter_quote_generator/global/generated/fonts.gen.dart';
import 'package:flutter_quote_generator/global/themes/app_color_theme.dart';
import 'package:flutter_quote_generator/global/themes/app_text_theme.dart';

class AppTheme {
  static final dark = () {
    return ThemeData(
      brightness: Brightness.dark,
      // fontFamily: FontFamily.lineSeedSansTh,
      useMaterial3: true,
    ).copyWith(
      scaffoldBackgroundColor: darkAppColors.background,
      extensions: [
        darkAppColors,
        darkTextTheme,
      ],
    );
  }();

  static final darkAppColors = AppColorThemeExtension(
    primary: AppColorPalette.buttercup,
    onPrimary: AppColorPalette.codGrey,
    secondary: AppColorPalette.blueChill,
    onSecondary: AppColorPalette.codGrey,
    error: AppColorPalette.cinnabar,
    onError: AppColorPalette.codGrey,
    success: AppColorPalette.persianGreen,
    onSuccess: AppColorPalette.codGrey,
    background: AppColorPalette.codGrey,
    onBackground: AppColorPalette.riceCake,
    surface: AppColorPalette.mineShaft,
    onSurface: AppColorPalette.riceCake,
  );

  static final darkTextTheme = AppTextThemeExtension(
    displayLarge: AppTextTheme.displayLarge.copyWith(
      color: darkAppColors.onBackground,
    ),
    displayMedium: AppTextTheme.displayMedium.copyWith(
      color: darkAppColors.onBackground,
    ),
    displaySmall: AppTextTheme.displaySmall.copyWith(
      color: darkAppColors.onBackground,
    ),
    headlineLarge: AppTextTheme.headlineLarge.copyWith(
      color: darkAppColors.onBackground,
    ),
    headlineMedium: AppTextTheme.headlineMedium.copyWith(
      color: darkAppColors.onBackground,
    ),
    headlineSmall: AppTextTheme.headlineSmall.copyWith(
      color: darkAppColors.onBackground,
    ),
    titleLarge: AppTextTheme.titleLarge.copyWith(
      color: darkAppColors.onBackground,
    ),
    titleMedium: AppTextTheme.titleMedium.copyWith(
      color: darkAppColors.onBackground,
    ),
    titleSmall: AppTextTheme.titleSmall.copyWith(
      color: darkAppColors.onBackground,
    ),
    bodyLarge: AppTextTheme.bodyLarge.copyWith(
      color: darkAppColors.onBackground,
    ),
    bodyMedium: AppTextTheme.bodyMedium.copyWith(
      color: darkAppColors.onBackground,
    ),
    bodySmall: AppTextTheme.bodySmall.copyWith(
      color: darkAppColors.onBackground,
    ),
    molecules: AppTextTheme.molecules.copyWith(
      color: darkAppColors.onBackground,
    ),
  );
}

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension AppThemeExtension on ThemeData {
  AppColorThemeExtension get color =>
      extension<AppColorThemeExtension>() ?? AppTheme.darkAppColors;
  AppTextThemeExtension get text => extension<AppTextThemeExtension>()!;
}
