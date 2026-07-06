import 'package:flo_wallet/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
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
      backgroundColor: context.colors.background,
      appBar: showBackButton
          ? AppBar(
              leading: const CustomBackButton(),
              backgroundColor: context.colors.background,
              scrolledUnderElevation: 0,
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, showBackButton ? 6 : 32, 16, 0),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: ApptextStyle.titleStyle(size: 22)),
                    SizedBox(height: 12),
                    Text(subtitle, style: ApptextStyle.subtitleTextStyle()),
                    SizedBox(height: 20),
                    body,
                    Spacer(),
                    ElevatedButton(
                      style: AppStyles.primaryButtonStyle,
                      onPressed: isEnabled
                          ? () {
                              FocusScope.of(context).unfocus();
                              onSubmit();
                            }
                          : null,
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CustomCircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              titleButton ?? "Next",
                              style: TextStyle(color: context.colors.secondary),
                            ),
                    ),
                    SizedBox(height: 24),
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
