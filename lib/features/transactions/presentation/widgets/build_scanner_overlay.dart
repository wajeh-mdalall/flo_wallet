import 'package:flo_wallet/features/transactions/presentation/widgets/scanner_border_printer.dart';
import 'package:flutter/material.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final double scanArea = MediaQuery.of(context).size.width * 0.65;
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withAlpha(70),
            BlendMode.srcOut,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: scanArea,
              width: scanArea,
              decoration: BoxDecoration(color: Colors.black),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: scanArea,
            width: scanArea,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
            ),
            child: CustomPaint(painter: ScannerBorderPainter()),
          ),
        ),
      ],
    );
  }
}
