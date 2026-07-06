import 'package:flo_wallet/core/cache/cache_helper.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flo_wallet/core/injection/core_di.dart';
import 'package:flo_wallet/features/onboarding/presentation/widgets/animated_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants.dart';
import '../widgets/onboarding_page_item.dart';
import 'onboarding_data.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _completeOnboarding() async {
    getIt<CacheHelper>().saveData(key: AppConstants.isFirstTime, value: false);
    if (mounted) context.go(AppConstants.kPhoneNumberView);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentIndex == onboardingPages.length - 1;

    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (!isLastPage)
            TextButton(
              onPressed: _completeOnboarding,
              child: Text(
                'Skip',
                style: AppTextStyle.titleStyle(
                  size: 16,
                  color: context.colors.primary,
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return OnboardingPageItem(pageModel: onboardingPages[index]);
                },
              ),
            ),
            AnimatedPageIndicator(
              itemCount: onboardingPages.length,
              currentIndex: _currentIndex,
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  if (isLastPage) {
                    _completeOnboarding();
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                style: AppStyles.primaryButtonStyle,
                child: Text(
                  isLastPage ? 'Get Started' : 'Next',
                  style: TextStyle(color: context.colors.secondary),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
