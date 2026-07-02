import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_colors.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const String _themeKey = 'app_theme_mode';

  ThemeCubit() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final index = prefs.getInt(_themeKey);
      if (index != null && index >= 0 && index < ThemeMode.values.length) {
        final mode = ThemeMode.values[index];
        _updateAppColors(mode);
        emit(mode);
      }
    } catch (_) {
      // Fallback to default
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _updateAppColors(mode);
    emit(mode);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, mode.index);
    } catch (_) {}
  }

  void _updateAppColors(ThemeMode mode) {
    if (mode == ThemeMode.light) {
      AppColors.updateTheme(false);
    } else if (mode == ThemeMode.dark) {
      AppColors.updateTheme(true);
    } else {
      // System mode: Will be evaluated dynamically based on platform brightness.
    }
  }

  void updateSystemTheme(bool isSystemDark) {
    if (state == ThemeMode.system) {
      AppColors.updateTheme(isSystemDark);
    }
  }
}
