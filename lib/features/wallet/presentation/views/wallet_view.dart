import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/functions/refresh_home_data.dart';
import 'package:flo_wallet/core/helper/date_helper.dart';
import 'package:flo_wallet/core/widgets/custom_card_details.dart';
import 'package:flo_wallet/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flo_wallet/core/widgets/custom_refresh_indicator.dart';
import 'package:flo_wallet/features/home/presentation/cubit/home_cubit.dart';
import 'package:flo_wallet/core/widgets/custom_scrollable_container.dart';
import 'package:flo_wallet/core/widgets/detail_tile.dart';
import 'package:flo_wallet/core/widgets/error_text_widget.dart';
import 'package:flo_wallet/features/wallet/presentation/widgets/wallet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final wallet = state.wallet;
        final bool isError =
            (state.status == HomeStatus.failure) && wallet != null;
        return SafeArea(
          child: CustomRefreshIndicator(
            isLoading: state.status == HomeStatus.loading,
            onRefresh: () async {
              refreshHomeData(context);
            },
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 16, 10, 10),
                    child: CustomScrollableContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WalletCard(wallet: wallet, isError: isError),
                          const SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              'Information',
                              style: AppTextStyle.titleStyle(size: 22),
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomCardDetails(items: _buildWalletDetails(state)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildWalletDetails(HomeState state) {
    final wallet = state.wallet;
    if (wallet != null) {
      return [
        DetailTile(
          icon: Icons.calendar_today_rounded,
          title: 'Created At',
          value: DateHelper.formatDate(wallet.createdAt),
        ),
        DetailTile(
          icon: Icons.update_rounded,
          title: 'Last Updated',
          value: DateHelper.formatDate(wallet.lastUpdated),
        ),
        DetailTile(
          icon: Icons.currency_exchange_rounded,
          title: 'Currency Settings',
          value: '${wallet.currencyCode} (${wallet.currencySymbol})',
          withDivider: false,
        ),
      ];
    }
    if (state.status == HomeStatus.loading) {
      return const [CustomCircularProgressIndicator()];
    }
    return [ErrorTextWidget(errMessage: state.errMessage)];
  }
}
