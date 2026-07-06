import 'package:flo_wallet/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/models/onboarding_model.dart';

class OnboardingPageItem extends StatelessWidget {
  final OnboardingModel pageModel;

  const OnboardingPageItem({super.key, required this.pageModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            pageModel.image,
            height: MediaQuery.sizeOf(context).height * 0.35,
          ),
          const SizedBox(height: 40),
          Text(pageModel.title, style: ApptextStyle.titleStyle(size: 18)),
          const SizedBox(height: 16),
          Text(pageModel.description, style: ApptextStyle.subtitleTextStyle()),
        ],
      ),
    );
  }
}
