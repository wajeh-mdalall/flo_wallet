import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flo_wallet/features/user/domain/usecases/update_profile_usecase.dart';
import '../../../../../core/errors/failures/failure.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/upload_profile_image_usecase.dart';
import '../../../domain/usecases/upload_user_data_usecase.dart';
import '../../../../wallet/domain/usecases/create_wallet_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'user_profile_management_state.dart';

class UserProfileManagementCubit extends Cubit<UserProfileManagementState> {
  final UploadUserDataUsecase uploadUserDataUsecase;
  final CreateWalletUsecase createWalletUsecase;
  final UploadProfileImageUsecase uploadProfileImageUsecase;
  final UpdateProfileUsecase updateProfileUsecase;
  UserProfileManagementCubit({
    required this.uploadUserDataUsecase,
    required this.createWalletUsecase,
    required this.uploadProfileImageUsecase,
    required this.updateProfileUsecase,
  }) : super(UserProfileManagementInitial());
  Future<void> completeProfile({
    required String uId,
    required String name,
    required String dobString,
    required String country,
    required String phoneNumber,
    File? profileImage,
  }) async {
    emit(UserProfileManagementLoading());
    String? profileImageUrl = await _handleImageUpload(profileImage, uId);
    if (state is UserProfileManagementError) return;
    final DateTime dobDateTime = DateFormat('d MMM y').parse(dobString);
    final user = UserEntity(
      uId: uId,
      name: name,
      dateOfBirth: dobDateTime,
      country: country,
      phoneNumber: phoneNumber,
      profileImageUrl: profileImageUrl,
    );

    final Either<Failure, Unit> userResult = await uploadUserDataUsecase(
      user: user,
    );
    userResult.fold(
      (failure) => emit(UserProfileManagementError(failure.errMessage)),
      (_) async {
        final Either<Failure, Unit> walletResult = await createWalletUsecase(
          uId: uId,
        );
        walletResult.fold(
          (failure) => emit(UserProfileManagementError(failure.errMessage)),
          (_) => emit(ProfileSetupSuccess()),
        );
      },
    );
  }

  Future<void> updateProfile({
    required UserEntity oldUser,
    required String name,
    required String dobString,
    required String country,
    File? newProfileImage,
  }) async {
    emit(UserProfileManagementLoading());
    String? finalImageUrl = oldUser.profileImageUrl;
    if (newProfileImage != null) {
      finalImageUrl = await _handleImageUpload(newProfileImage, oldUser.uId);
      if (state is UserProfileManagementError) return;
    }

    final DateTime dobDateTime = DateFormat('d MMM y').parse(dobString);
    final user = UserEntity(
      uId: oldUser.uId,
      name: name,
      dateOfBirth: dobDateTime,
      country: country,
      phoneNumber: oldUser.phoneNumber,
      profileImageUrl: finalImageUrl,
    );
    if (oldUser == user) {
      emit(ProfileUpdateSuccess());
      return;
    }

    final Either<Failure, Unit> result = await updateProfileUsecase(user: user);
    result.fold(
      (failure) => emit(UserProfileManagementError(failure.errMessage)),
      (_) => emit(ProfileUpdateSuccess()),
    );
  }

  Future<String?> _handleImageUpload(File? image, String uId) async {
    if (image == null) return null;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final String path = 'users_avatars/${uId}_$timestamp';

    final Either<Failure, String> imageResult = await uploadProfileImageUsecase(
      file: image,
      path: path,
    );

    return imageResult.fold((failure) {
      emit(UserProfileManagementError(failure.errMessage));
      return null;
    }, (url) => url);
  }
}
