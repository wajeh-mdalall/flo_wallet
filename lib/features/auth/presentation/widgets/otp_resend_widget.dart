import 'dart:async';

import 'package:flo_wallet/core/constants.dart';
import 'package:flutter/material.dart';

class OtpResendWidget extends StatefulWidget {
  final VoidCallback onResend;
  const OtpResendWidget({super.key, required this.onResend});
  @override
  State<OtpResendWidget> createState() => _OtpResendWidgetState();
}

class _OtpResendWidgetState extends State<OtpResendWidget> {
  Timer? _timer;
  int _counter = 60;
  bool _canResend = false;
  void _startTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
    _counter = 60;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter == 0) {
        setState(() {
          _canResend = true;
        });
        _timer?.cancel();
      } else {
        setState(() {
          _counter--;
        });
      }
    });
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Didn't receive the code? "),
        TextButton(
          onPressed: _canResend
              ? () {
                  widget.onResend();
                  _startTimer();
                }
              : null,
          child: Text(
            _canResend ? "Resend Code" : "Resend in $_counter s",
            style: TextStyle(
              color: _canResend ? AppColors.primary : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
