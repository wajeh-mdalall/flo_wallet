import '../../../../core/constants.dart';
import '../cubit/auth_cubit.dart';
import '../../../../core/functions/show_error_dialog.dart';
import '../../../../core/widgets/custom_input_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../widgets/custom_phone_number_input.dart';

class PhoneNumberView extends StatefulWidget {
  const PhoneNumberView({super.key});

  @override
  State<PhoneNumberView> createState() => _PhoneNumberViewState();
}

class _PhoneNumberViewState extends State<PhoneNumberView> {
  bool isValidate = false;
  String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go(AppConstants.kHomeView);
        }
        if (state is CodeSent) {
          context.go(
            AppConstants.kVerifyOtpView,
            extra: {
              AppExtraKeys.kVerificationId: state.data.verificationId,
              AppExtraKeys.kPhoneNumber: state.data.phoneNumber,
            },
          );
        }
        if (state is AuthError) {
          showErrorDialog(context, state.errMessage);
        }
      },
      builder: (context, state) => CustomInputScaffold(
        showBackButton: false,
        title: "Enter your mobile number",
        subtitle: "A verification code will be sent to this number.",
        body: CustomPhoneInputWidget(
          onInputValidated: (value) {
            setState(() {
              isValidate = value;
            });
          },
          onInputChanged: (PhoneNumber number) {
            phoneNumber = number.phoneNumber;
          },

          errorText: (!isValidate && phoneNumber != null)
              ? "Please enter a valid phone number"
              : null,
        ),

        onSubmit: () {
          if (phoneNumber != null) {
            context.read<AuthCubit>().sendPhoneNumber(
              phoneNumber: phoneNumber!,
            );
          }
        },
        isEnabled: isValidate,
        isLoading: state is AuthLoading,
      ),
    );
  }
}
