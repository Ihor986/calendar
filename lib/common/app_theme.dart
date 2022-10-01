import 'package:calendar/common/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  const AppThemes._();

  static ThemeData light() {
    final ThemeData lightTheme = ThemeData(brightness: Brightness.light);
    return lightTheme.copyWith(
      colorScheme: const ColorScheme.light(),
      scaffoldBackgroundColor: AppColors.gray,
    );
  }
}
