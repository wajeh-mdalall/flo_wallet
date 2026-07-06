import 'package:flo_wallet/core/injection/core_di.dart';
import 'package:flo_wallet/core/theme/app_theme_colors.dart';
import 'package:flo_wallet/core/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ThemeContext on BuildContext {
  AppThemeColors get colors {
    try {
      return watch<ThemeCubit>().state.colors;
    } catch (_) {
      return getIt<ThemeCubit>().state.colors;
    }
  }
}
