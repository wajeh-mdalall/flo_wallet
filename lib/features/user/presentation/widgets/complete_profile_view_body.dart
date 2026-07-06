import 'dart:io';
import 'user_avatar_picker.dart';
import '../../../../core/widgets/build_section_widget.dart';
import 'country_dropdown_form_field.dart';
import 'date_of_birth_form_field.dart';
import 'full_name_textformfield.dart';
import 'package:flutter/material.dart';

class CompleteProfileViewBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController dobController;
  final TextEditingController countryController;
  final Function(File? image) onImageSelected;
  final String? initialImageUrl;
  const CompleteProfileViewBody({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.dobController,
    required this.countryController,
    required this.onImageSelected,
    this.initialImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildSectionWidget(
            title: "Profile Picture",
            child: UserAvatarPicker(
              onImageSelected: onImageSelected,
              initialImageUrl: initialImageUrl,
            ),
          ),
          SizedBox(height: 12),
          BuildSectionWidget(
            title: "Full Name",
            child: FullNameTextformfield(controller: nameController),
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: BuildSectionWidget(
                  title: "Date Of Birth",
                  child: DateOfBirthFormField(controller: dobController),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: BuildSectionWidget(
                  title: "Country",
                  child: CountryDropdownFormField(
                    controller: countryController,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
