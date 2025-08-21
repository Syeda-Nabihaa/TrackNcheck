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

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(settings);

    // Create notification channel for Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'expiry_channel',
      'Expiry Reminders',
      description: 'Notifications for product expiry reminders',
      importance: Importance.high,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Request permissions
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle background messages
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
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
    );
  }

  Future<void> scheduleExpiryNotificationAlt({
  required String productName,
  required DateTime expiryDate,
  int daysBefore = 30,
  int hour = 14, // Default reminder time: 2 PM
  int minute = 0,
}) async {
  // 1️⃣ Calculate the reminder date
  final DateTime notificationDate = expiryDate.subtract(Duration(days: daysBefore));

  // 2️⃣ Set the reminder time (e.g., 2:00 PM)
  final DateTime notificationDateTime = DateTime(
    notificationDate.year,
    notificationDate.month,
    notificationDate.day,
    hour,
    minute,
  );

  final now = DateTime.now();

  // 3️⃣ Fire immediately if the reminder time is already past
  if (notificationDateTime.isBefore(now)) {
    await _showNotification(
      title: 'Expiry Reminder: $productName',
      body: 'Your product "$productName" expires on ${expiryDate.toString().split(' ')[0]}.',
    );
    return;
  }

  // 4️⃣ Schedule notification using timezone-aware DateTime
  final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
    notificationDateTime,
    tz.local,
  );

  // 5️⃣ Notification details
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'expiry_channel',
    'Expiry Reminders',
    channelDescription: 'Notifications for product expiry reminders',
    importance: Importance.high,
    priority: Priority.high,
  );

  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
    iOS: iosDetails,
  );

  // 6️⃣ Schedule notification
  await _notifications.zonedSchedule(
    // Unique ID for each reminder
    productName.hashCode + daysBefore,
    'Expiry Reminder: $productName',
    'Your product "$productName" expires on ${expiryDate.toString().split(' ')[0]}.',
    scheduledDate,
    notificationDetails,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    matchDateTimeComponents: null,
   
  );
}


  Future<void> scheduleImmediateNotification({
  required String productName,
  required DateTime expiryDate,
}) async {
  // Fire immediately
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'expiry_channel',
    'Expiry Reminders',
    channelDescription: 'Immediate notifications for new products',
    importance: Importance.high,
    priority: Priority.high,
  );

  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
    iOS: iosDetails,
  );

  await _notifications.show(
    productName.hashCode, // unique ID for this product
    'Expiry Reminder: $productName',
    'Your product "$productName" expires on ${expiryDate.toString().split(' ')[0]}.',
    notificationDetails,
  );
}



  // ✅ Only 30 days and 7 days reminders now
  Future<void> scheduleMultipleReminders({
    required String productName,
    required DateTime expiryDate,
  }) async {
    // 30 days before
    await scheduleExpiryNotificationAlt(
      productName: productName,
      expiryDate: expiryDate,
      daysBefore: 30,
    );

    // 7 days before
    await scheduleExpiryNotificationAlt(
      productName: productName,
      expiryDate: expiryDate,
      daysBefore: 7,
    );
     await scheduleImmediateNotification(
  productName: productName,
  expiryDate: expiryDate,
);
  }

  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  // Test method to check if notifications work
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
