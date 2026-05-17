import 'package:equatable/equatable.dart';

class GetTransactionsParams extends Equatable {
  final String uId;
  final int? limit;

  const GetTransactionsParams({required this.uId, this.limit});

  @override
  List<Object?> get props => [uId, limit];
}
