import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flo_wallet/core/functions/show_confirmation_dialog.dart';
import 'package:flo_wallet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        minWidth: double.infinity,
        color: context.colors.primary,
        onPressed: () {
          showConfirmationDialog(
            context,
            confirmText: "Sign Out",
            "Are you sure you want to sign out of your account?",
            onConfirm: () {
              context.read<AuthCubit>().signOut();
            },
          );
        },
        child: Text("Sign Out", style: ApptextStyle.titleStyle(size: 14)),
      ),
    );
  }
}
