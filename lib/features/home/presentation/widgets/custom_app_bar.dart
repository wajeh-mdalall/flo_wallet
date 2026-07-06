import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flo_wallet/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int index;
  const CustomAppBar(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    Color background = index == 1 || index == 2
        ? context.colors.background.level(0.9)
        : Colors.transparent;
    String? title = index == 1
        ? "Transaction"
        : index == 2
        ? "Wallet"
        : null;

    return AppBar(
      backgroundColor: background,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: title != null
          ? Text(title, style: ApptextStyle.titleStyle(size: 24))
          : null,
    );
  }

  @override
  Size get preferredSize => index == 0
      ? const Size.fromHeight(10)
      : index == 3
      ? Size.zero
      : const Size.fromHeight(kToolbarHeight);
}
