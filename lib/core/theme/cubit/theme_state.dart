part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final AppThemeColors colors;
  final bool isDarkMode;
  const ThemeState({required this.colors, required this.isDarkMode});

  @override
  List<Object> get props => [colors, isDarkMode];
}
