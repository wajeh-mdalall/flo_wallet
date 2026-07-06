import 'package:flo_wallet/core/extensions/theme_extension.dart';

import 'package:flutter/material.dart';

class NavigationBarItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const NavigationBarItem({
    super.key,
    required this.index,
    required this.icon,
    required this.title,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = index == currentIndex;
    return Expanded(
      child: InkWell(
        splashColor: context.colors.primary.withValues(alpha: 0.1),
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? context.colors.primary
                    : context.colors.secondary,
                size: 24,
              ),
              Text(
                title,
                style: TextStyle(
                  color: isSelected
                      ? context.colors.primary
                      : context.colors.secondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
