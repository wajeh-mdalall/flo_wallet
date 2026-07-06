import 'package:equatable/equatable.dart';

class GetTransactionsParams extends Equatable {
  final String uId;
  final int limit;
  final String? lastTransactionId;

  const GetTransactionsParams({
    required this.uId,
    required this.limit,
    this.lastTransactionId,
  });

  @override
  List<Object?> get props => [uId, limit];
}
