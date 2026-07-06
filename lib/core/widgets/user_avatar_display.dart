import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flo_wallet/core/extensions/color_extension.dart';
import 'package:flo_wallet/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class UserAvatarDisplay extends StatelessWidget {
  final File? imageFile; // picked
  final String? imageUrl; // Firestore
  final double radius;
  final double iconSize;

  const UserAvatarDisplay({
    super.key,
    this.imageFile,
    this.imageUrl,
    this.radius = 50,
    this.iconSize = 50,
  });

  @override
  Widget build(BuildContext context) {
    final double diameter = radius * 2;

    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colors.background.level(0.9),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: _getAvatarWidget(context),
      ),
    );
  }

  Widget? _getAvatarWidget(BuildContext context) {
    if (imageFile != null) {
      return Image.file(imageFile!, fit: BoxFit.cover);
    }
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: SizedBox(
            width: iconSize / 2,
            height: iconSize / 2,
            child: CustomCircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => _buildDefaultIcon(context),
      );
    }
    return _buildDefaultIcon(context);
  }

  Widget _buildDefaultIcon(BuildContext context) {
    return Center(
      child: Icon(
        Icons.person,
        size: iconSize,
        color: context.colors.secondary,
      ),
    );
  }
}
