import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/functions/show_custom_modal_bottom_sheet.dart';

import 'package:flo_wallet/core/widgets/qr_code_widget.dart';
import 'package:flutter/material.dart';

void showQrBottomSheet(
  BuildContext context, {
  required String uId,
  required String name,
  required String? profileImageUrl,
}) {
  showCustomModalBottomSheet(
    context,
    body: Column(
      children: [
        Text(
          "Let the sender scan this QR code to receive money instantly",
          textAlign: TextAlign.center,
          style: ApptextStyle.hintTextStyle(),
        ),
        const SizedBox(height: 20),
        QrCodeWidget(uId: uId, name: name, profileImage: profileImageUrl),
      ],
    ),
  );
}
