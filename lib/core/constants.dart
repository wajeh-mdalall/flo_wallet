import 'package:flo_wallet/core/injection/core_di.dart';
import 'package:flo_wallet/core/theme/app_theme_colors.dart';
import 'package:flo_wallet/core/theme/cubit/theme_cubit.dart';

import 'package:flutter/material.dart';

abstract class AppConstants {
  static const String uIdKey = "user_id";
  static const String uNameKey = "user_name";
  static const String uProfileImageKey = "user_profileImage";
  static const String isFirstTime = "is_first_time";
  static const Duration timeOut = Duration(seconds: 60);
  // Routes
  static const String kOnboardingView = "/onboardingView";
  static const String kPhoneNumberView = "/phoneNumberView";
  static const String kVerifyOtpView = "/verifyOtpView";
  static const String kHomeView = "/homeView";
  static const String kCompleteProfile = "/CompleteProfile";
  static const String kQrScannerView = "/QrScannerView";
  static const String kSendMoneyAmountView = "/SendMoneyAmountView";
  static const String kTransactionsView = "/TransactionsView";
  static const String kWalletView = "/WalletView";
  static const String kProfileView = "/ProfileView";
  static const String kUserSearchView = "/UserSearchView";
}

abstract class AppExtraKeys {
  static const String kUId = "uId";
  static const String kPhoneNumber = "phoneNumber";
  static const String kVerificationId = "verificationId";
  static const String kCurrentUserId = "currentUserId";
  static const String kCurrentUserName = "currentUserName";
  static const String kCurrentUserPhoneNumber = "currentUserPhoneNumber";
  static const String kSenderId = "senderId";
  static const String kSenderName = "senderName";
  static const String kReceiverId = "receiverId";
  static const String kReceiverName = "receiverName";
  static const String kReceiverProfileImage = "receiverProfileImage";
  static const String kUser = "user";
}

abstract class ApptextStyle {
  static Color get textColor => AppStyles.themeColorsNotifier.value.secondary;
  static TextStyle hintTextStyle() {
    return TextStyle(
      color: textColor.withAlpha(175),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle inputTextStyle() {
    return TextStyle(color: textColor, fontWeight: FontWeight.bold);
  }

  static TextStyle subtitleTextStyle({Color? color}) {
    final Color subtitleColor = color ?? textColor;
    return TextStyle(color: subtitleColor.withAlpha(128), fontSize: 14);
  }

  static TextStyle titleStyle({
    required double size,
    bool useAlpha = false,
    Color? color,
  }) {
    final Color titleColor = color ?? textColor;
    return TextStyle(
      color: useAlpha ? titleColor.withAlpha(128) : titleColor,
      fontWeight: FontWeight.bold,
      fontSize: size,
    );
  }
}

abstract class AppStyles {
  static final ValueNotifier<AppThemeColors> themeColorsNotifier =
      ValueNotifier<AppThemeColors>(getIt<ThemeCubit>().state.colors);
  static Color get primaryColor => themeColorsNotifier.value.primary;
  static Color get backgroundColor => themeColorsNotifier.value.background;

  // themes
  static ThemeData get themeData => ThemeData(
    textTheme: TextTheme(bodyLarge: ApptextStyle.inputTextStyle()),
    canvasColor: backgroundColor,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: primaryColor.withAlpha(100),
      selectionHandleColor: primaryColor,
    ),
  );
  // button
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size(double.infinity, 40),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    backgroundColor: primaryColor,
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
      errorStyle: TextStyle(color: primaryColor),
      hintText: hintText,
      hintStyle: ApptextStyle.hintTextStyle(),
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 10, right: 4),
              child: Icon(prefixIcon, color: primaryColor, size: 20),
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
      borderSide: BorderSide(color: primaryColor),
      borderRadius: BorderRadius.circular(25),
    );
  }
}
