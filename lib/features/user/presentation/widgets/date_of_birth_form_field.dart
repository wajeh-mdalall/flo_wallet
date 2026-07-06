import 'package:flo_wallet/core/helper/date_helper.dart';
import '../../../../core/constants.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class DateOfBirthFormField extends StatefulWidget {
  final TextEditingController controller;
  const DateOfBirthFormField({super.key, required this.controller});

  @override
  State<DateOfBirthFormField> createState() => _DateOfBirthFormFieldState();
}

class _DateOfBirthFormFieldState extends State<DateOfBirthFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: AppStyles.customTextFieldDecoration(
        hintText: "Born on",
        prefixIcon: Icons.cake,
        contentPaddingHorizontal: 0,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "required";
        }
        return null;
      },
      readOnly: true,
      onTap: _selectDate,
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      initialDate: DateTime(2000),

      builder: (context, child) {
        return Transform.scale(
          scale: 0.8,
          child: Theme(
            data: ThemeData(
              dividerTheme: DividerThemeData(color: context.colors.secondary),
              colorScheme: ColorScheme.light(
                primary: context.colors.primary,
                onSurface: context.colors.secondary,
                surface: context.colors.background,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: context.colors.primary,
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );
    if (picked != null) {
      setState(() {
        widget.controller.text = DateHelper.formatBirthDate(picked);
      });
    }
  }
}
