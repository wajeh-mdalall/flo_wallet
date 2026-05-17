import 'package:flo_wallet/core/functions/show_error_dialog.dart';

import '../../../../core/constants.dart';
import '../cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthGateView extends StatelessWidget {
  const AuthGateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go(AppConstants.kHomeView, extra: state.authUser.uId);
        } else if (state is Unauthenticated) {
          context.go(AppConstants.kPhoneNumberView);
        } else if (state is AuthError) {
          showErrorDialog(context, state.errMessage);
        }
      },
      child: Scaffold(body: Center(child: const CircularProgressIndicator())),
    );
  }
}
