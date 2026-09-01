import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flo_wallet/features/user/domain/usecases/update_fcm_token_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localPlugin =
      FlutterLocalNotificationsPlugin();

  static const String _channelId = 'flo_wallet_transactions';
  static const String _channelName = 'Wallet Transactions';
  static const String _customSound = 'notification_sound';

  static VoidCallback? onNotificationClicked;

  
  static Future<void> initialize() async {
    await _requestPermissions();
    await _setupAndroidChannel();
    await _initLocalNotifications();
    _setupNotificationListeners();
  }

  static Future<void> _requestPermissions() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      criticalAlert: true,
    );
  }

  static Future<void> _setupAndroidChannel() async {
    final androidImplementation = _localPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidImplementation != null) {
      await androidImplementation.createNotificationChannel(
        const AndroidNotificationChannel(
          _channelId,
          _channelName,
          importance: Importance.max,
          playSound: true,
          enableVibration: true,
          sound: RawResourceAndroidNotificationSound(_customSound),
        ),
      );
    }
  }

  static Future<void> _initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('ic_notification');
    const initSettings = InitializationSettings(android: androidSettings);

    await _localPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (_) => _handleNotificationClick(),
    );
  }

  static void _setupNotificationListeners() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) _handleNotificationClick();
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (_) => _handleNotificationClick(),
    );

    FirebaseMessaging.onMessage.listen(_showNotification);
  }

  static NotificationDetails _getNotificationDetails() {
    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      sound: RawResourceAndroidNotificationSound(_customSound),
    );
    return const NotificationDetails(android: androidDetails);
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    if (message.notification != null) {
      await _localPlugin.show(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: message.notification!.title,
        body: message.notification!.body,
        notificationDetails: _getNotificationDetails(),
      );
    }
  }

  static void _handleNotificationClick() {
    onNotificationClicked?.call();
  }

  static Future<void> syncUserFcmToken(
    String uId,
    UpdateFcmTokenUsecase updateFcmTokenUsecase,
  ) async {
    try {
      String? currentToken = await FirebaseMessaging.instance.getToken();
      if (currentToken != null) {
        await updateFcmTokenUsecase(uId: uId, token: currentToken);
      }
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
        await updateFcmTokenUsecase(uId: uId, token: newToken);
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Error syncing FCM Token: $e");
      }
    }
  }

  static Future<void> showSenderSuccessNotification({
    required String recipientName,
    required int amount,
  }) async {
    await _localPlugin.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: 'Transfer Successful',
      body: 'You have successfully sent \$$amount to $recipientName.',
      notificationDetails: _getNotificationDetails(),
    );
  }
}
