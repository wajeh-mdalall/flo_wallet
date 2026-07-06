import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flo_wallet/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flo_wallet/core/widgets/custom_refresh_indicator.dart';
import 'package:flo_wallet/core/widgets/transaction_list_view.dart';
import 'package:flo_wallet/features/transactions/presentation/cubit/transactions_cubit/transactions_cubit.dart';
import 'package:flo_wallet/core/widgets/custom_scrollable_container.dart';
import 'package:flo_wallet/core/widgets/error_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsView extends StatefulWidget {
  final String uId;
  const TransactionsView({super.key, required this.uId});

  @override
  State<TransactionsView> createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final cubit = context.read<TransactionsCubit>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      if (cubit.state.status != TransactionsStatus.loading &&
          cubit.state.status != TransactionsStatus.loadingMore &&
          !cubit.state.hasReachedMax) {
        context.read<TransactionsCubit>().fetchTransactions(uId: widget.uId);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<TransactionsCubit, TransactionsState>(
              builder: (context, state) {
                final isStateLoading =
                    state.status == TransactionsStatus.loading;
                return CustomRefreshIndicator(
                  isLoading: isStateLoading,
                  onRefresh: () async {
                    await context.read<TransactionsCubit>().fetchTransactions(
                      uId: widget.uId,
                      isRefresh: true,
                    );
                  },
                  child: _buildRefreshableContent(state),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefreshableContent(TransactionsState state) {
    if (state.status == TransactionsStatus.loading &&
        state.transactions.isEmpty) {
      return const CustomCircularProgressIndicator();
    }
    if (state.status == TransactionsStatus.failure &&
        state.transactions.isEmpty) {
      return CustomScrollableContainer(
        child: ErrorTextWidget(errMessage: state.errMessage),
      );
    }
    if (state.transactions.isEmpty) {
      return CustomScrollableContainer(
        child: Center(
          child: Text(
            "You don't have any transactions yet",
            style: ApptextStyle.titleStyle(
              size: 22,
              color: context.colors.secondary,
            ),
          ),
        ),
      );
    }
    return TransactionListView(
      scrollController: _scrollController,
      transactions: state.transactions,
      currentUId: widget.uId,
      isLoadingMore: state.status == TransactionsStatus.loadingMore,
    );
  }
}
