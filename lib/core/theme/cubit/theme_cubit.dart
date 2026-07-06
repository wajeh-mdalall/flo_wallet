import 'dart:ui';
import 'package:flo_wallet/core/cache/cache_helper.dart';
import 'package:flo_wallet/core/injection/core_di.dart';
import 'package:flo_wallet/core/theme/app_theme_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static CacheHelper cacheHelper = getIt<CacheHelper>();
  static const String _themeKey = "is_dark_mode";
  static bool _isSystemDarkMode() {
    final brightness = PlatformDispatcher.instance.platformBrightness;
    return brightness == Brightness.dark;
  }

  static ThemeState _getInitialState() {
    final bool isDark =
        cacheHelper.getData(key: _themeKey) as bool? ?? _isSystemDarkMode();

    return isDark
        ? ThemeState(colors: AppThemeColors.dark(), isDarkMode: true)
        : ThemeState(colors: AppThemeColors.light(), isDarkMode: false);
  }

  ThemeCubit() : super(_getInitialState());
  void toggleTheme() async {
    if (state.isDarkMode) {
      emit(ThemeState(colors: AppThemeColors.light(), isDarkMode: false));
      await cacheHelper.saveData(key: _themeKey, value: false);
    } else {
      emit(ThemeState(colors: AppThemeColors.dark(), isDarkMode: true));
      await cacheHelper.saveData(key: _themeKey, value: true);
    }
  }
}
