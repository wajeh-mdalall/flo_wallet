import 'package:flo_wallet/core/cache/cache_helper.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flo_wallet/core/functions/show_error_dialog.dart';
import 'package:flo_wallet/core/injection/core_di.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
      listener: (context, state) async {
        if (state is Authenticated) {
          FlutterNativeSplash.remove();
          context.go(AppConstants.kHomeView);
        } else if (state is Unauthenticated) {
          final bool isFirstTime =
              getIt<CacheHelper>().getData(key: AppConstants.isFirstTime) ??
              true;
          FlutterNativeSplash.remove();
          if (isFirstTime) {
            context.go(AppConstants.kOnboardingView);
          } else {
            context.go(AppConstants.kPhoneNumberView);
          }
        } else if (state is AuthError) {
          FlutterNativeSplash.remove();
          showErrorDialog(context, state.errMessage,requiresSignIn: true);
        }
      },
      child: Scaffold(
        backgroundColor: context.colors.primary,
        body: SizedBox.shrink(),
      ),
    );
  }
}
