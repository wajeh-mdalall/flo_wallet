part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final UserEntity? user;
  final WalletEntity? wallet;
  final List<TransactionEntity>? transactions;
  final String? errMessage;
  final bool requiresSignIn;
  const HomeState({
    required this.status,
    this.user,
    this.wallet,
    this.transactions,
    this.errMessage,
    this.requiresSignIn = false,
  });

  factory HomeState.initial() {
    return const HomeState(status: HomeStatus.initial);
  }
  HomeState copyWith({
    HomeStatus? status,
    UserEntity? user,
    WalletEntity? wallet,
    List<TransactionEntity>? transactions,
    String? errMessage,
    bool? requiresSignIn,
  }) {
    return HomeState(
      status: status ?? this.status,
      user: user ?? this.user,
      wallet: wallet ?? this.wallet,
      transactions: transactions ?? this.transactions,
      errMessage: errMessage ?? this.errMessage,
      requiresSignIn: requiresSignIn ?? this.requiresSignIn,
    );
  }

  @override
  List<Object?> get props => [status, user, wallet, transactions, errMessage];
}
