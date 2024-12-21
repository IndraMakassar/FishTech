import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Notifikasi'),
        backgroundColor: const Color(0xFF42A5F5),
      ),
      body: ListView(
        children: [
          CustomNotifWidget(),
          CustomNotifWidget(),
          CustomNotifWidget(),
          CustomNotifWidget(),
          CustomNotifWidget(),
        ],
      ),
    );
  }
}

class CustomNotifWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the width of the screen
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        width: screenWidth,  // Set the width to 100% of the screen width
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
        child: const Row(
          children: [
            Icon(Icons.notifications_none_outlined, color: Colors.blue),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Kolam Nila 1", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Kondisi Kolam Nila 1, Baik", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("2:30 pm", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 4),
                Text(".", style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
