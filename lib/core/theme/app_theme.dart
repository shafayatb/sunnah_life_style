import 'package:flutter/material.dart';
import 'package:sunnah_life_style/core/theme/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.lightSeedColor,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );

  static ThemeData get dark => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.darkSeedColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
