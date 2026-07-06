import 'package:flo_wallet/features/home/presentation/widgets/custom_user_list_tile.dart';
import '../../../../core/constants.dart';
import 'package:flutter/material.dart';

class UserBalanceHeader extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final int balance;
  final String currencySymbol;
  final VoidCallback onRefresh;

  const UserBalanceHeader({
    super.key,
    required this.name,
    this.imageUrl,
    required this.balance,
    required this.currencySymbol,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomUserListTile(
            name: name,
            imageUrl: imageUrl,
            onRefresh: onRefresh,
          ),
          SizedBox(height: 12),
          Center(
            child: Text(
              "$currencySymbol $balance",
              style: AppTextStyle.titleStyle(size: 30),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              "Available Balance",
              style: AppTextStyle.titleStyle(size: 12, useAlpha: true),
            ),
          ),
        ],
      ),
    );
  }
}
