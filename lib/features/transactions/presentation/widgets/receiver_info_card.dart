import 'package:flo_wallet/core/extensions/theme_extension.dart';

import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/extensions/color_extension.dart';
import 'package:flo_wallet/core/widgets/short_id_text.dart';
import 'package:flo_wallet/core/widgets/user_avatar_display.dart';
import 'package:flutter/material.dart';

class ReceiverInfoCard extends StatelessWidget {
  final String id;
  final String name;
  final String? profileImage;
  const ReceiverInfoCard({
    super.key,
    required this.id,
    required this.name,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.background.level(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withAlpha(60)),
      ),
      child: Row(
        children: [
          UserAvatarDisplay(imageUrl: profileImage, iconSize: 65),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  style: ApptextStyle.titleStyle(
                    size: 18,
                  ).copyWith(fontFamily: 'monospace'),
                  overflow: TextOverflow.clip,
                ),
                const SizedBox(height: 4),
                ShortIdText(id: id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
