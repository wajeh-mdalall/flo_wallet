import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flo_wallet/core/widgets/short_id_text.dart';
import 'package:flo_wallet/features/wallet/domain/entities/wallet_entity.dart';
import 'package:flo_wallet/core/widgets/error_text_widget.dart';
import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  final WalletEntity? wallet;
  final bool isError;
  const WalletCard({required this.wallet, super.key, required this.isError});
  @override
  Widget build(BuildContext context) {
    final bool isActive = isError ? wallet!.isActive : true;
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isActive
              ? [
                  const Color(0xFF254EA3),
                  const Color(0xFF3C69C9),
                  const Color(0xFF5A88EC),
                ]
              : [Colors.grey[700]!, Colors.grey[800]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [AppStyles.shadow],
      ),
      padding: const EdgeInsets.all(26.0),
      child: _buildWalletCardBody(context, isActive),
    );
  }

  Widget _buildWalletCardBody(BuildContext context, bool isActive) {
    final Color activeStatusColor = isActive
        ? Colors.greenAccent
        : Colors.redAccent;
    if (wallet != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                wallet!.currencyCode,
                style: AppTextStyle.titleStyle(
                  size: 16,
                ).copyWith(letterSpacing: 1.5),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: activeStatusColor.withAlpha(60),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: activeStatusColor, width: 1),
                ),
                child: Text(
                  isActive ? 'Active' : 'Inactive',
                  style: AppTextStyle.titleStyle(
                    size: 12,
                    color: activeStatusColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current Balance', style: AppTextStyle.hintTextStyle()),
              const SizedBox(height: 4),
              Text(
                "${wallet!.currencySymbol} ${wallet!.balance}",
                style: AppTextStyle.titleStyle(size: 38),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShortIdText(id: wallet!.walletId, withTitle: false, size: 18),
              Icon(
                Icons.account_balance_wallet_rounded,
                color: context.colors.secondary,
                size: 30,
              ),
            ],
          ),
        ],
      );
    }
    if (isError) {
      return const ErrorTextWidget();
    }
    return const CustomCircularProgressIndicator();
  }
}
