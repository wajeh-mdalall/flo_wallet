import 'package:flo_wallet/core/extensions/color_extension.dart';
import 'package:flo_wallet/core/widgets/short_id_text.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flo_wallet/core/helper/qr_coder_helper.dart';

class QrCodeWidget extends StatelessWidget {
  final String uId;
  final String name;
  final String? profileImage;
  const QrCodeWidget({
    super.key,
    required this.uId,
    required this.name,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    final String qrData = QrCoderHelper.encodeUserData(
      uId: uId,
      name: name,
      profileImage: profileImage,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.level(0.9),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(12),
          child: QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: 220,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: Colors.black,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.circle,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ShortIdText(id: uId),
      ],
    );
  }
}
