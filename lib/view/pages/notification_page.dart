import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  List<Map<String, String>> notifications = [
    {"title": "Kolam Nila 1", "subtitle": "Kondisi Kolam Nila 1, Baik", "time": "2:30 pm"},
  ];

  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }

  void initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          print('Notification clicked with payload: ${response.payload}');
          // Handle navigation or actions based on the payload
        }
      },
    );
  }

  void showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'your_channel_id', 
      'Your Channel Name',
      channelDescription: 'Your channel description',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0, 
      title, 
      body, 
      notificationDetails, 
      payload: 'Custom Payload', 
    );
  }

  void addNotification() {
    final newNotification = {
      "title": "Kolam Baru",
      "subtitle": "Kondisi Kolam Baru, Sedang",
      "time": TimeOfDay.now().format(context),
    };

    setState(() {
      notifications.add(newNotification);
    });

    showNotification(newNotification["title"]!, newNotification["subtitle"]!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifikasi"),
        backgroundColor: const Color(0xFF42A5F5),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.notifications_none_outlined, color: Colors.blue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification["title"]!,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(notification["subtitle"]!,
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Text(notification["time"]!,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNotification,
        child: const Icon(Icons.add),
      ),
    );
  }
}
