part of 'wallet_cubit.dart';

sealed class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

final class WalletInitial extends WalletState {}

final class WalletLoading extends WalletState {}

final class WalletCreated extends WalletState {}

final class WalletLoaded extends WalletState {
  final WalletEntity wallet;
  const WalletLoaded(this.wallet);

  @override
  List<Object> get props => [wallet];
}

final class WalletError extends WalletState {
  final String errMessage;
  const WalletError(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
