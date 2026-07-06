import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flo_wallet/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class CustomCardDetails extends StatelessWidget {
  final List<Widget> items;
  final bool withPadding;
  const CustomCardDetails({
    super.key,
    required this.items,
    this.withPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOneitem = items.length == 1;
    return Container(
      padding: withPadding ? EdgeInsets.all(16) : null,
      decoration: BoxDecoration(
        color: context.colors.background.level(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppStyles.shadow],
      ),
      child: Column(
        children: isOneitem ? [SizedBox(height: 230, child: items[0])] : items,
      ),
    );
  }
}
