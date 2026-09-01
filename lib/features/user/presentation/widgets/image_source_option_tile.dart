import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ImageSourceOptionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const ImageSourceOptionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final secondaryColor = context.colors.secondary;
    return ListTile(
      leading: Icon(Icons.photo_library, color: secondaryColor),
      title: Text(title, style: TextStyle(color: secondaryColor)),
      onTap: onTap,
    );
  }
}
