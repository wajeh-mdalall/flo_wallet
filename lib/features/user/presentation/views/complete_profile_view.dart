import 'dart:io';
import 'package:flo_wallet/core/helper/date_helper.dart';
import 'package:flo_wallet/core/injection/core_di.dart';
import 'package:flo_wallet/features/home/presentation/cubit/home_cubit.dart';
import 'package:flo_wallet/features/user/domain/entities/user_entity.dart';
import '../../../../core/constants.dart';
import '../../../../core/functions/show_error_dialog.dart';
import '../../../../core/widgets/custom_input_scaffold.dart';
import '../cubit/complete_profile_cubit/user_profile_management_cubit.dart';
import '../widgets/complete_profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CompleteProfileView extends StatefulWidget {
  final String? uId;
  final String? phoneNumber;
  final UserEntity? userEntity;
  const CompleteProfileView({
    super.key,
    this.uId,
    this.phoneNumber,
    this.userEntity,
  });

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  File? _selectedImage;
  bool _isEnabled = false;
  bool get _isEditMode => widget.userEntity != null;
  String _originalDobText = '';
  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _setupListeners();
  }

  void _initializeControllers() {
    if (_isEditMode) {
      final user = widget.userEntity!;
      _nameController.text = user.name;
      _countryController.text = user.country;
      _originalDobText = DateHelper.formatBirthDate(user.dateOfBirth);
      _dobController.text = _originalDobText;
    }
  }

  void _setupListeners() {
    _nameController.addListener(_validateForm);
    _dobController.addListener(_validateForm);
    _countryController.addListener(_validateForm);
  }

  void _validateForm() {
    final String nameText = _nameController.text.trim();
    final String dobText = _dobController.text.trim();
    final String countryText = _countryController.text.trim();
    final bool allFieldsNotEmpty =
        nameText.isNotEmpty && dobText.isNotEmpty && countryText.isNotEmpty;
    if (_isEditMode) {
      final user = widget.userEntity!;
      final bool isDataChanged =
          nameText != user.name ||
          countryText != user.country ||
          dobText != _originalDobText ||
          _selectedImage != null;

      setState(() {
        _isEnabled = allFieldsNotEmpty && isDataChanged;
      });
    } else {
      setState(() {
        _isEnabled = allFieldsNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    _nameController.removeListener(_validateForm);
    _dobController.removeListener(_validateForm);
    _countryController.removeListener(_validateForm);
    _nameController.dispose();
    _dobController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileManagementCubit, UserProfileManagementState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          getIt<HomeCubit>().fetchHomeData(uId: widget.userEntity!.uId);
          context.pop();
        }
        if (state is ProfileSetupSuccess) {
          context.go(AppConstants.kHomeView, extra: widget.uId);
        }
        if (state is UserProfileManagementError) {
          showErrorDialog(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return CustomInputScaffold(
          showBackButton: _isEditMode,
          title: _isEditMode ? "Update Profile" : "Complete your profile",
          subtitle: _isEditMode
              ? "Update your personal details here."
              : "Enter your personal details to set up your wallet.",
          body: CompleteProfileViewBody(
            formKey: _formKey,
            nameController: _nameController,
            dobController: _dobController,
            countryController: _countryController,
            initialImageUrl: widget.userEntity?.profileImageUrl,
            onImageSelected: (image) {
              _selectedImage = image;
              _validateForm();
            },
          ),
          titleButton: _isEditMode ? "Save Changes" : "Save & Continue",
          onSubmit: () {
            if (_formKey.currentState!.validate()) {
              if (_isEditMode) {
                context.read<UserProfileManagementCubit>().updateProfile(
                  name: _nameController.text.trim(),
                  dobString: _dobController.text,
                  country: _countryController.text,
                  newProfileImage: _selectedImage,
                  oldUser: widget.userEntity!,
                );
              } else {
                context.read<UserProfileManagementCubit>().completeProfile(
                  uId: widget.uId ?? "",
                  name: _nameController.text.trim(),
                  dobString: _dobController.text,
                  country: _countryController.text,
                  phoneNumber: widget.phoneNumber ?? "",
                  profileImage: _selectedImage,
                );
              }
            }
          },
          isEnabled: _isEnabled,
          isLoading: state is UserProfileManagementLoading,
        );
      },
    );
  }
}
