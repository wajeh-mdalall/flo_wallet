import 'package:dartz/dartz.dart';
import 'package:flo_wallet/core/errors/failures/failure.dart';
import 'package:flo_wallet/features/transactions/domain/usecases/send_money/send_money_params.dart';
import 'package:flo_wallet/features/transactions/domain/usecases/send_money/send_money_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'send_money_state.dart';

class SendMoneyCubit extends Cubit<SendMoneyState> {
  final SendMoneyUsecase sendMoneyUsecase;
  SendMoneyCubit({required this.sendMoneyUsecase})
    : super(SendMoneyInitial());

  Future<void> sendMoney({
    required String senderId,
    required String senderName,
    required String receiverId,
    required String receiverName,
    required int amount,
     String? title,
  }) async {
    emit(SendMoneyLoading());
    final SendMoneyParams params = SendMoneyParams(
      senderId: senderId,
      senderName: senderName,
      receiverId: receiverId,
      receiverName: receiverName,
      amount: amount,
      title: title,
    );
    final Either<Failure, Unit> result = await sendMoneyUsecase(params);
    result.fold(
      (failure) => emit(SendMoneyError(failure.errMessage)),
      (_) => emit(SendMoneySuccess()),
    );
  }
}
