import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _notifications.initialize(settings);

    // Android channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'expiry_channel',
      'Expiry Reminders',
      description: 'Notifications for product expiry reminders',
      importance: Importance.high,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Request permissions
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  }

  static Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
    await _showNotification(
      title: message.notification?.title ?? 'Expiry Reminder',
      body: message.notification?.body ?? 'Product expiry date is near',
    );
  }

  static Future<void> _showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'expiry_channel',
      'Expiry Reminders',
      channelDescription: 'Notifications for product expiry reminders',
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails details =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
    );
  }

  /// Cancel single notification by ID
  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  /// Cancel all notifications (for testing/debug)
  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  /// Schedule a notification for a specific date
  Future<void> scheduleNotification({
    required String productName,
    required DateTime expiryDate,
    required int daysBefore,
  }) async {
    final scheduledDate = expiryDate.subtract(Duration(days: daysBefore));

    if (scheduledDate.isBefore(DateTime.now())) return; // skip if in past

    final tz.TZDateTime tzDate = tz.TZDateTime.from(scheduledDate, tz.local);

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'expiry_channel',
      'Expiry Reminders',
      channelDescription: 'Notifications for product expiry reminders',
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails details =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notifications.zonedSchedule(
      productName.hashCode + daysBefore,
      'Expiry Reminder: $productName',
      'Your product "$productName" expires on ${expiryDate.toString().split(' ')[0]}',
      tzDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: null,
    );
  }

  /// Schedule multiple reminders: 30-day, 7-day
  Future<void> scheduleMultipleReminders({
    required String productName,
    required DateTime expiryDate,
  }) async {
    // Cancel old notifications for this product
    await cancelNotification(productName.hashCode + 30);
    await cancelNotification(productName.hashCode + 7);
    await cancelNotification(productName.hashCode + 999);

    // Schedule 30-day reminder
    await scheduleNotification(
      productName: productName,
      expiryDate: expiryDate,
      daysBefore: 30,
    );

    // Schedule 7-day reminder
    await scheduleNotification(
      productName: productName,
      expiryDate: expiryDate,
      daysBefore: 7,
    );
  }

  /// Optional immediate notification
  Future<void> scheduleImmediateNotification({
    required String productName,
    required DateTime expiryDate,
  }) async {
    await _showNotification(
      title: 'Expiry Reminder: $productName',
      body: 'Your product "$productName" expires on ${expiryDate.toString().split(' ')[0]}',
    );
  }

  Future<void> testNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'expiry_channel',
      'Expiry Reminders',
      channelDescription: 'Notifications for product expiry reminders',
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      999,
      'Test Notification',
      'This is a test notification to verify setup',
      details,
    );
  }
}



