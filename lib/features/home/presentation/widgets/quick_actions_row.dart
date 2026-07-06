import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';

import 'custom_action_button.dart';
import 'package:flutter/material.dart';

class QuickActionsRow extends StatelessWidget {
  final VoidCallback onSendTap;
  final VoidCallback onRequestTap;

  const QuickActionsRow({
    super.key,
    required this.onSendTap,
    required this.onRequestTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppStyles.shadow],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomActionButton(
              icon: Icons.arrow_upward,
              title: "Send",
              iconColor: Colors.blueAccent,
              onTap: onSendTap,
            ),
            Container(height: 30, width: 1, color: context.colors.secondary),
            CustomActionButton(
              icon: Icons.arrow_downward,
              title: "Request",
              iconColor: Colors.orangeAccent,
              onTap: onRequestTap,
            ),
          ],
        ),
      ),
    );
  }
}
