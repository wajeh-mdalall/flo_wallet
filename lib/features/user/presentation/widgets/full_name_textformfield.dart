import '../../../../core/constants.dart';
import 'package:flutter/material.dart';

class FullNameTextformfield extends StatelessWidget {
  final TextEditingController controller;
  const FullNameTextformfield({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Full name is required";
        }
        return null;
      },
      controller: controller,
      decoration: AppStyles.customTextFieldDecoration(
        hintText: "Enter your display name",
        prefixIcon: Icons.person,
      ).copyWith(helperText: ' ', helperStyle: const TextStyle(fontSize: 12)),
    );
  }
}
