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

abstract class ApptextStyle {
  static final Color textColor = AppColors.secondary;
  static TextStyle hintTextStyle() {
    return TextStyle(
      color: textColor.withAlpha(175),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle inputTextStyle() {
    return TextStyle(color: textColor, fontWeight: FontWeight.bold);
  }

  static TextStyle titleStyle({required double size, bool useAlpha = false}) {
    return TextStyle(
      color: useAlpha ? textColor.withAlpha(128) : textColor,
      fontWeight: FontWeight.bold,
      fontSize: size,
    );
  }
}

abstract class AppStyles {
  // themes
  static final ThemeData themeData = ThemeData(
    textTheme: TextTheme(bodyLarge: ApptextStyle.inputTextStyle()),
    canvasColor: AppColors.background,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: AppColors.primary.withAlpha(100),
      selectionHandleColor: AppColors.primary,
    ),
  );
  // button
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size(double.infinity, 40),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    backgroundColor: AppColors.primary,
    disabledBackgroundColor: Colors.grey,
  );
  // boxShadow
  static final BoxShadow shadow = BoxShadow(
    color: Colors.black.withAlpha(100),
    blurRadius: 15,
    offset: const Offset(0, 8),
  );
  // textField
  static InputDecoration customTextFieldDecoration({
    IconData? prefixIcon,
    String? hintText,
    String? errorText,
    double? contentPaddingHorizontal,
  }) {
    return InputDecoration(
      errorText: errorText,
      errorStyle: const TextStyle(color: AppColors.primary),
      hintText: hintText,
      hintStyle: ApptextStyle.hintTextStyle(),
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 10, right: 4),
              child: Icon(prefixIcon, color: AppColors.primary, size: 20),
            )
          : null,
      prefixIconConstraints: BoxConstraints(),
      focusedBorder: customOutlineInputBorder(),
      errorBorder: customOutlineInputBorder(),
      focusedErrorBorder: customOutlineInputBorder(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      contentPadding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: contentPaddingHorizontal ?? 16,
      ),
    );
  }

  static OutlineInputBorder customOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary),
      borderRadius: BorderRadius.circular(25),
    );
  }
}
