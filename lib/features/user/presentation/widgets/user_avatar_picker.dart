import 'dart:io';
import '../../../../core/widgets/user_avatar_display.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';

class UserAvatarPicker extends StatefulWidget {
  final Function(File? image) onImageSelected;
  final String? initialImageUrl;
  const UserAvatarPicker({
    super.key,
    required this.onImageSelected,
    this.initialImageUrl,
  });

  @override
  State<UserAvatarPicker> createState() => _UserAvatarPickerState();
}

class _UserAvatarPickerState extends State<UserAvatarPicker> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 50,
      maxWidth: 500,
    );

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
      widget.onImageSelected(_pickedImage);
      if (mounted) context.pop();
    }
  }

  void _showPickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => _pickImage(ImageSource.camera),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          UserAvatarDisplay(
            imageFile: _pickedImage,
            imageUrl: widget.initialImageUrl,
          ),
          GestureDetector(
            onTap: _showPickerOptions,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: context.colors.secondary,
              child:  Icon(
                Icons.camera_alt,
                size: 18,
                color: context.colors.background,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
