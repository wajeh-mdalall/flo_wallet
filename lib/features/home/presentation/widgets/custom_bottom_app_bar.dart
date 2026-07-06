import 'package:flo_wallet/core/extensions/theme_extension.dart';
import '../../../../core/extensions/color_extension.dart';
import 'navigation_bar_item.dart';
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const CustomBottomAppBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: context.colors.background.level(0.9),
      shape: CircularNotchedRectangle(),
      padding: EdgeInsets.zero,
      height: 62,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                NavigationBarItem(
                  index: 0,
                  icon: Icons.home,
                  title: "Home",
                  onTap: () => onTap(0),
                  currentIndex: currentIndex,
                ),
                NavigationBarItem(
                  index: 1,
                  icon: Icons.pie_chart_rounded,
                  title: "Trans.",
                  onTap: () => onTap(1),
                  currentIndex: currentIndex,
                ),
              ],
            ),
          ),
          SizedBox(width: 60),
          Expanded(
            child: Row(
              children: [
                NavigationBarItem(
                  index: 2,
                  icon: Icons.wallet,
                  title: "Wallet",
                  onTap: () => onTap(2),
                  currentIndex: currentIndex,
                ),
                NavigationBarItem(
                  index: 3,
                  icon: Icons.person,
                  title: "Profile",
                  onTap: () => onTap(3),
                  currentIndex: currentIndex,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
