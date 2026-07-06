import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final VoidCallback onTap;
  const CustomActionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: context.colors.primary.withValues(alpha: 0.1),
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: iconColor, size: 28),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: context.colors.secondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
