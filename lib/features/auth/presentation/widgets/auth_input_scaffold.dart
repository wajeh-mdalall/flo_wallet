import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/features/auth/presentation/widgets/custom_back_button_widget.dart';
import 'package:flutter/material.dart';

class AuthInputScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget input;
  final String? titleButton;
  final VoidCallback onSubmit;
  final bool isLoading;
  final bool isEnabled;

  const AuthInputScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.input,
    required this.onSubmit,
    required this.isEnabled,
    required this.isLoading,
    this.titleButton,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: CustomBackButtonWidget(),
        backgroundColor: AppColors.background,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 20),
                  input,
                  Spacer(),
                  ElevatedButton(
                    style: AppStyles.primaryButtonStyle,
                    onPressed: isEnabled ? onSubmit : null,
                    child: isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.secondary,
                            ),
                          )
                        : Text(
                            titleButton ?? "Next",
                            style: TextStyle(color: AppColors.secondary),
                          ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
