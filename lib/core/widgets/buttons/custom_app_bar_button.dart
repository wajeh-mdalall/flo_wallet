import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class CustomAppBarButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  const CustomAppBarButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: context.colors.secondary),
      iconSize: 25,
    );
  }
}
