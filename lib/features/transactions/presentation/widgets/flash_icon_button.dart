import 'package:flo_wallet/core/extensions/theme_extension.dart';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class FlashIconButton extends StatelessWidget {
  final MobileScannerController controller;
  const FlashIconButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MobileScannerState>(
      valueListenable: controller,
      builder: (context, state, child) {
        final isTorchOn = state.torchState == TorchState.on;
        return IconButton(
          icon: Icon(
            isTorchOn ? Icons.flash_on : Icons.flash_off,
            color: isTorchOn ? Colors.amberAccent : context.colors.background,
          ),
          onPressed: () => controller.toggleTorch(),
        );
      },
    );
  }
}
