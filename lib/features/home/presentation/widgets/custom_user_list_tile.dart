import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flo_wallet/core/widgets/buttons/custom_app_bar_button.dart';
import 'package:flo_wallet/core/widgets/user_avatar_display.dart';
import 'package:flutter/material.dart';

class CustomUserListTile extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final VoidCallback onRefresh;
  const CustomUserListTile({
    super.key,
    required this.name,
    this.imageUrl,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: UserAvatarDisplay(
            radius: 28,
            iconSize: 40,
            imageUrl: imageUrl,
          ),
          title: Text(
            "Welcome back",
            style: ApptextStyle.titleStyle(size: 10, useAlpha: true),
          ),
          subtitle: Text(
            name,
            style: ApptextStyle.titleStyle(
              size: 14,
            ).copyWith(fontFamily: 'monospace'),
          ),
          trailing: CustomAppBarButton(
            onPressed: onRefresh,
            icon: Icons.refresh,
          ),
        ),
        Divider(
          color: context.colors.secondary.withAlpha(100),
          thickness: 2,
          indent: 60,
          endIndent: 60,
        ),
      ],
    );
  }
}
