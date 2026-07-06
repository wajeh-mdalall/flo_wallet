part of 'qr_scanner_cubit.dart';

sealed class QrScannerState extends Equatable {
  const QrScannerState();

  @override
  List<Object?> get props => [];
}

final class QrScannerInitial extends QrScannerState {}

class QrScannerLoading extends QrScannerState {}

class QrScannerSuccess extends QrScannerState {
  final String receiverId;
  final String receiverName;
  final String? receiverProfileImage;

  const QrScannerSuccess({
    required this.receiverId,
    required this.receiverName,
    this.receiverProfileImage,
  });
  @override
  List<Object?> get props => [receiverId, receiverName, receiverProfileImage];
}

class QrScannerError extends QrScannerState {
  final String errMessage;

  const QrScannerError({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}
