import '../constants.dart';
import 'package:flutter/material.dart';

class BuildSectionWidget extends StatelessWidget {
  final String title;
  final Widget child;
  const BuildSectionWidget({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: AppTextStyle.titleStyle(size: 14)),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
