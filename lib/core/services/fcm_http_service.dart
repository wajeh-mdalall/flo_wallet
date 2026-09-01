import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

class FcmHttpService {
  static const String _projectId = 'flo-wallet-app';
  static const String _channelId = 'flo_wallet_transactions';

  static Future<String> _getAccessToken() async {
    final jsonString = await rootBundle.loadString(
      'assets/service_account.json',
    );
    final accountCredentials = auth.ServiceAccountCredentials.fromJson(
      jsonString,
    );
    const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final client = await auth.clientViaServiceAccount(
      accountCredentials,
      scopes,
    );
    return client.credentials.accessToken.data;
  }

  static Future<bool> sendTransferNotification({
    required String receiverFcmToken,
    required String senderName,
    required int amount,
  }) async {
    try {
      final String accessToken = await _getAccessToken();

      final response = await http.post(
        Uri.parse(
          'https://fcm.googleapis.com/v1/projects/$_projectId/messages:send',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'message': {
            'token': receiverFcmToken,
            'notification': {
              'title': 'Payment Received 💰',
              'body': 'You received \$$amount from $senderName',
            },
            'data': {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'type': 'transfer_received',
            },
            'android': {
              'priority': 'HIGH',
              'notification': {
                'channel_id': _channelId,
                'notification_priority': 'PRIORITY_MAX',
                'sound': 'notification_sound',
                'icon': 'ic_notification',
              },
            },
          },
        }),
      );
      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Exception while sending notification: $e");
      }
      return false;
    }
  }
}
