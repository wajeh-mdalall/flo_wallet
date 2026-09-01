import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<void> uploadUserData({required UserModel user});
  Future<UserModel> getUserData({required String uId});
  Future<void> updateProfile({required UserModel user});
  Future<UserModel> findUserByPhone({required String phoneNumber});
  Future<void> updateFcmToken({required String uId, required String token});
}
