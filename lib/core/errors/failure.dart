import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errMessage;

  const Failure(this.errMessage);
  @override
  List<Object?> get props => [errMessage];
}

class OfflineFailure extends Failure {
  const OfflineFailure()
    : super("No internet connection. Please check your network.");
}

class ServerFailure extends Failure {
  const ServerFailure()
    : super("Something went wrong on the server. Please try again.");
}

class TimeOutFailure extends Failure {
  const TimeOutFailure() : super("The request timed out. Please try again.");
}
