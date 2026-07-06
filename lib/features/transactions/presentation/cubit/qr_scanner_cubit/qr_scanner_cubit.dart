import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/helper/qr_coder_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'qr_scanner_state.dart';

class QrScannerCubit extends Cubit<QrScannerState> {
  QrScannerCubit() : super(QrScannerInitial());

  void decodeAndValidateQr({
    required String? rawData,
    required String currentUserId,
  }) {
    emit(QrScannerLoading());

    final Map<String, String?>? decodedData = QrCoderHelper.decodeQrData(
      rawData,
    );
    if (decodedData == null) {
      emit(
        QrScannerError(
          errMessage:
              "Invalid QR Code. Please scan a valid Flo Wallet QR code.",
        ),
      );
      return;
    }

    final String receiverId = decodedData[AppConstants.uIdKey]!;
    final String receiverName = decodedData[AppConstants.uNameKey]!;
    final String? receiverProfileImage =
        decodedData[AppConstants.uProfileImageKey];

    if (receiverId == currentUserId) {
      emit(
        QrScannerError(
          errMessage:
              "Transaction Denied. You cannot send money to your own wallet.",
        ),
      );
      return;
    }

    emit(
      QrScannerSuccess(
        receiverId: receiverId,
        receiverName: receiverName,
        receiverProfileImage: receiverProfileImage,
      ),
    );
  }

  void resetScanner() {
    emit(QrScannerInitial());
  }
}
