import 'package:dartz/dartz.dart';
import 'package:flo_wallet/core/errors/failures/failure.dart';
import 'package:flo_wallet/features/user/domain/usecases/find_user_by_phone_usecase.dart';
import '../../../domain/entities/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_search_state.dart';

class UserSearchCubit extends Cubit<UserSearchState> {
  final FindUserByPhoneUsecase findUserByPhoneUsecase;
  UserSearchCubit({required this.findUserByPhoneUsecase})
    : super(UserSearchInitial());
  Future<void> findUserByPhone({
    required String phoneNumber,
    required String currentUserPhoneNumber,
  }) async {
    emit(UserSearchLoading());
    if (phoneNumber == currentUserPhoneNumber) {
      emit(
        UserSearchError(
          "Transaction Denied. You cannot send money to your own wallet.",
        ),
      );
      return;
    }
    final Either<Failure, UserEntity> result = await findUserByPhoneUsecase(
      phoneNumber: phoneNumber,
    );
    result.fold(
      (failure) => emit(UserSearchError(failure.errMessage)),
      (user) => emit(UserSearchFound(user)),
    );
  }
}
