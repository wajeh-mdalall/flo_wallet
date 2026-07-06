import 'dart:convert';
import '../constants.dart';

class QrCoderHelper {
  static String encodeUserData({
    required String uId,
    required String name,
    required String? profileImage,
  }) {
    final Map<String, dynamic> data = {
      AppConstants.uIdKey: uId,
      AppConstants.uNameKey: name,
      AppConstants.uProfileImageKey: profileImage,
    };
    return jsonEncode(data);
  }

  static Map<String, String?>? decodeQrData(String? rawData) {
    if (rawData == null || rawData.isEmpty) return null;

    try {
      final decoded = jsonDecode(rawData);

      if (decoded is Map &&
          decoded.containsKey(AppConstants.uIdKey) &&
          decoded.containsKey(AppConstants.uNameKey)) {
        return {
          AppConstants.uIdKey: decoded[AppConstants.uIdKey].toString(),
          AppConstants.uNameKey: decoded[AppConstants.uNameKey].toString(),
          AppConstants.uProfileImageKey: decoded[AppConstants.uProfileImageKey]
              ?.toString(),
        };
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
