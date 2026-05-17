import '../constants.dart';
import 'buttons/custom_back_button.dart';
import 'package:flutter/material.dart';

class CustomInputScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget body;
  final String? titleButton;
  final VoidCallback onSubmit;
  final bool isLoading;
  final bool isEnabled;
  final bool showBackButton;

  const CustomInputScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.onSubmit,
    required this.isEnabled,
    required this.isLoading,
    this.titleButton,
    this.showBackButton = true,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: showBackButton
          ? AppBar(
              leading: const CustomBackButton(),
              backgroundColor: AppColors.background,
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(18, showBackButton ? 12 : 32, 18, 12),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: ApptextStyle.titleStyle(size: 22)),
                    SizedBox(height: 12),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: AppColors.secondary.withAlpha(128),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 20),
                    body,
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
      ),
    );
  }
}
