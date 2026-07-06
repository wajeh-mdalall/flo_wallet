import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/widgets/custom_circle_icon.dart';
import 'package:flutter/material.dart';

class DetailTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool withDivider;
  final Widget? trailing;

  const DetailTile({
    required this.icon,
    required this.title,
    required this.value,
    this.withDivider = true,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CustomCircleIcon(
                icon: icon,
                color: context.colors.background,
                radius: 22,
                size: 20,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyle.titleStyle(size: 14)),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: AppTextStyle.titleStyle(size: 14, useAlpha: true),
                    ),
                  ],
                ),
              ),
              trailing ?? const SizedBox(),
            ],
          ),
        ),
        if (withDivider)
          Divider(
            height: 1,
            indent: 70,
            endIndent: 16,
            color: context.colors.secondary.withAlpha(60),
          ),
      ],
    );
  }
}
