import 'package:flo_wallet/core/injection/core_di.dart';
import 'package:flo_wallet/core/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';

class ThemeSwitch extends StatelessWidget {
  final bool isDarkMode;
  const ThemeSwitch({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Switch(
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {
        return Colors.transparent;
      }),
      activeThumbColor: const Color(0xFF292929),
      inactiveThumbColor: const Color(0xFFFFFFFF),
      trackColor: WidgetStateColor.resolveWith((_) => const Color(0xFF3C69C9)),
      thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
        return Icon(
          states.contains(WidgetState.selected)
              ? Icons.dark_mode
              : Icons.light_mode,
          color: const Color(0xFF3C69C9),
        );
      }),
      value: isDarkMode,
      onChanged: (value) {
        getIt<ThemeCubit>().toggleTheme();
      },
    );
  }
}
