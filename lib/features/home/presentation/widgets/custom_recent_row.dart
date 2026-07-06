import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomRecentRow extends StatelessWidget {
  const CustomRecentRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text("Recent", style: AppTextStyle.titleStyle(size: 20)),
          IconButton(
            onPressed: () {
              StatefulNavigationShell.of(context).goBranch(1);
            },
            icon: Icon(
              Icons.keyboard_arrow_right_outlined,
              size: 32,
              color: context.colors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
