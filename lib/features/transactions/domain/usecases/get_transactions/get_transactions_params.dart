import 'package:equatable/equatable.dart';

class GetTransactionsParams extends Equatable {
  final String userId;
  final int? limit; 

  const GetTransactionsParams({
    required this.userId,
    this.limit, 
  });

  @override
  List<Object?> get props => [userId, limit];
}