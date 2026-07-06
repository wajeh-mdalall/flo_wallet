part of 'send_money_cubit.dart';

sealed class SendMoneyState extends Equatable {
  const SendMoneyState();

  @override
  List<Object?> get props => [];
}class SendMoneyInitial extends SendMoneyState {}
class SendMoneyLoading extends SendMoneyState {}


class SendMoneySuccess extends SendMoneyState {}

class SendMoneyError extends SendMoneyState {
  final String errMessage;

  const SendMoneyError(this.errMessage);
  @override
  List<Object?> get props => [errMessage];
}
