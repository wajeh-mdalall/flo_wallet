import 'package:flo_wallet/core/functions/refresh_home_data.dart';
import 'package:flo_wallet/core/functions/show_qr_bottom_sheet.dart';
import 'package:flo_wallet/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flo_wallet/core/widgets/transactions_empty_message.dart';
import 'package:flo_wallet/features/home/presentation/cubit/home_cubit.dart';
import 'package:flo_wallet/features/home/presentation/widgets/custom_recent_row.dart';
import 'package:flo_wallet/core/widgets/transaction_list_view.dart';
import 'package:flo_wallet/features/home/presentation/widgets/user_error_header.dart';
import 'package:flo_wallet/core/widgets/error_text_widget.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import '../../../../core/constants.dart';
import '../../../../core/functions/show_error_dialog.dart';
import '../widgets/quick_Actions_row.dart';
import '../widgets/user_balance_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.status == HomeStatus.failure && state.requiresSignIn) {
          showErrorDialog(
            context,
            state.errMessage,
            requiresSignIn: state.requiresSignIn,
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    boxShadow: [AppStyles.shadow],
                  ),
                  child: _buildHeaderBody(context, state),
                ),
                Positioned(
                  bottom: -40,
                  left: 0,
                  right: 0,
                  child: QuickActionsRow(
                    onSendTap: () {
                      final user = state.user;
                      if (user != null) {
                        context.push(
                          AppConstants.kUserSearchView,
                          extra: {
                            AppExtraKeys.kCurrentUserId: user.uId,
                            AppExtraKeys.kCurrentUserName: user.name,
                            AppExtraKeys.kCurrentUserPhoneNumber:
                                user.phoneNumber,
                          },
                        );
                      }
                    },
                    onRequestTap: () {
                        final user = state.user;
                      if (user != null) {
                        showQrBottomSheet(
                          context,
                          uId: user.uId,
                          name: user.name,
                          profileImageUrl: user.profileImageUrl,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 70),
            CustomRecentRow(),
            Expanded(child: _buildRecentBody(state)),
          ],
        );
      },
    );
  }

  Widget _buildRecentBody(HomeState state) {
    if (state.transactions != null && state.user != null) {
      if (state.transactions!.isEmpty) {
        return TransactionsEmptyMessage();
      }
      return TransactionListView(
        currentUId: state.user!.uId,
        transactions: state.transactions!,
      );
    }
    if (state.status == HomeStatus.loading) {
      return const CustomCircularProgressIndicator();
    }
    if (state.status == HomeStatus.failure) {
      return ErrorTextWidget(errMessage: state.errMessage);
    }
    return SizedBox();
  }

  Widget _buildHeaderBody(BuildContext context, HomeState state) {
    if (state.user != null && state.wallet != null) {
      return UserBalanceHeader(
        name: state.user!.name,
        imageUrl: state.user!.profileImageUrl,
        balance: state.wallet!.balance,
        currencySymbol: state.wallet!.currencySymbol,
        onRefresh: () {
          refreshHomeData(context);
        },
      );
    }
    if (state.status == HomeStatus.loading) {
      return const CustomCircularProgressIndicator();
    }
    return UserErrorHeader(
      onRefresh: () {
        refreshHomeData(context);
      },
    );
  }
}
