import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';

import 'package:flo_wallet/core/widgets/buttons/custom_back_button.dart';
import 'package:flo_wallet/features/transactions/presentation/cubit/qr_scanner_cubit/qr_scanner_cubit.dart';
import 'package:flo_wallet/features/transactions/presentation/widgets/build_scanner_overlay.dart';
import 'package:flo_wallet/features/transactions/presentation/widgets/flash_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flo_wallet/core/functions/show_error_dialog.dart';
import 'package:go_router/go_router.dart';

class QrScannerView extends StatefulWidget {
  final String currentUserId;
  final String currentUserName;
  const QrScannerView({
    super.key,
    required this.currentUserId,
    required this.currentUserName,
  });

  @override
  State<QrScannerView> createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  final MobileScannerController _cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QrScannerCubit, QrScannerState>(
      listener: (context, state) {
        if (state is QrScannerSuccess) {
          _cameraController.stop().then((_) {
            if (context.mounted) {
              context.pushReplacement(
                AppConstants.kSendMoneyAmountView,
                extra: {
                  AppExtraKeys.kSenderId: widget.currentUserId,
                  AppExtraKeys.kSenderName: widget.currentUserName,
                  AppExtraKeys.kReceiverId: state.receiverId,
                  AppExtraKeys.kReceiverName: state.receiverName,
                  AppExtraKeys.kReceiverProfileImage:
                      state.receiverProfileImage,
                },
              );
            }
          });
        }

        if (state is QrScannerError) {
          showErrorDialog(
            context,
            state.errMessage,
            onPressed: () {
              context.read<QrScannerCubit>().resetScanner();
            },
          );
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: CustomBackButton(color: context.colors.background),
          actions: [FlashIconButton(controller: _cameraController)],
        ),
        body: Stack(
          children: [
            MobileScanner(
              controller: _cameraController,
              onDetect: (capture) {
                final barcode = capture.barcodes.first.rawValue;
                final state = context.read<QrScannerCubit>().state;
                if (barcode != null &&
                    state is! QrScannerLoading &&
                    state is! QrScannerSuccess) {
                  context.read<QrScannerCubit>().decodeAndValidateQr(
                    rawData: barcode,
                    currentUserId: widget.currentUserId,
                  );
                }
              },
            ),
            ScannerOverlay(),
            Positioned(
              top: 90,
              left: 20,
              child: Text(
                'Scan QR Code',
                style: ApptextStyle.titleStyle(
                  size: 22,
                  color: context.colors.background,
                ),
              ),
            ),
            Positioned(
              top: 130,
              left: 20,
              child: Text(
                "Align the QR code within the frame to scan",
                textAlign: TextAlign.center,
                style: ApptextStyle.subtitleTextStyle(
                  color: context.colors.background,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
