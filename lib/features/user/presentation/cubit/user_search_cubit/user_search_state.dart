part of 'user_search_cubit.dart';

sealed class UserSearchState extends Equatable {
  const UserSearchState();

  @override
  List<Object?> get props => [];
}

final class UserSearchInitial extends UserSearchState {}

final class UserSearchLoading extends UserSearchState {}

final class UserSearchFound extends UserSearchState {
  final UserEntity user;
  const UserSearchFound(this.user);

  @override
  List<Object?> get props => [user];
}

final class UserSearchError extends UserSearchState {
  final String errMessage;
  const UserSearchError(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}
