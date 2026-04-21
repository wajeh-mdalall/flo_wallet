import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flo_wallet/features/auth/presentation/functions/show_error_dialog.dart';
import 'package:flo_wallet/features/auth/presentation/widgets/auth_input_scaffold.dart';
import 'package:flo_wallet/features/auth/presentation/widgets/otp_resend_widget.dart';
import 'package:flo_wallet/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpView extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const VerifyOtpView({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  bool isCompleted = false;
  String pin = '';
  late String _currentVerificationId;

  @override
  void initState() {
    _currentVerificationId = widget.verificationId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is CodeSent) {
              _currentVerificationId = state.data.verificationId;
            }
            if (state is AutoVerifying) {
              FocusScope.of(context).unfocus();
            }
            if (state is Authenticated) {
              if (state.user.isNewUser) {
                context.read<WalletCubit>().createWallet(
                  userId: state.user.uId,
                );
              } else {
                context.go(AppConstants.kHomeView);
              }
            }
            if (state is AuthError) {
              showErrorDialog(context, state.errMessage);
            }
          },
        ),
        BlocListener<WalletCubit, WalletState>(
          listener: (context, walletState) {
            if (walletState is WalletCreated) {
              context.go(AppConstants.kHomeView);
            }
            if (walletState is WalletError) {
              showErrorDialog(context, walletState.errMessage);
            }
          },
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return AuthInputScaffold(
            title: 'Enter the Code',
            subtitle:
                'A verification code has been sent to ${widget.phoneNumber}',
            input: Column(
              children: [
                Pinput(
                  autofillHints: const [AutofillHints.oneTimeCode],
                  enableSuggestions: true,
                  onChanged: (value) {
                    setState(() {
                      pin = value;
                      isCompleted = value.length == 6;
                    });
                  },
                  keyboardType: TextInputType.number,
                  length: 6,
                  focusedPinTheme: _pinTheme(color: Colors.blueAccent.shade100),
                  defaultPinTheme: _pinTheme(color: AppColors.primary),
                ),
                const SizedBox(height: 10),
                OtpResendWidget(
                  onResend: () {
                    context.read<AuthCubit>().sendPhoneNumber(
                      phoneNumber: widget.phoneNumber,
                    );
                  },
                ),
              ],
            ),
            onSubmit: () {
              context.read<AuthCubit>().confirmOtp(_currentVerificationId, pin);
            },
            titleButton: state is AutoVerifying
                ? "Automatically verifying code..."
                : null,
            isEnabled: isCompleted && state is! AutoVerifying,
            isLoading:
                state is AuthLoading ||
                context.watch<WalletCubit>().state is WalletLoading,
          );
        },
      ),
    );
  }

  PinTheme _pinTheme({required Color color}) {
    return PinTheme(
      width: 50,
      height: 60,
      textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.secondary,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
