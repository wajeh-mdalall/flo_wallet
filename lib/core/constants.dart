import 'package:flutter/material.dart';

abstract class AppConstants {
  static const String uidKey = "user_id";
  static const Duration timeOut = Duration(seconds: 60);
  // Routes
  static const String kPhoneNumberView = "/phoneNumberView";
  static const String kVerifyOtpView = "/verifyOtpView";
  static const String kHomeView = "/homeView";
}

abstract class AppColors {
  static const Color primary = Color.fromARGB(255, 60, 105, 201);
  static const Color secondary = Color.fromARGB(255, 41, 41, 41);
  static const Color background = Colors.white;
}

abstract class AppStyles {
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size(double.infinity, 40),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    backgroundColor: AppColors.primary,
    disabledBackgroundColor: Colors.grey,
  );
  static InputDecoration customTextFieldDecoration({required String hintText}) {
    return InputDecoration(
      errorStyle: const TextStyle(color: AppColors.primary),
      hintText: hintText,
      hintStyle: TextStyle(color: AppColors.secondary.withAlpha(175)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(25),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(25),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
    );
  }
}
