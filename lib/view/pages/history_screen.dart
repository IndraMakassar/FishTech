import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF37AFE1),
        title: const Text("History"),
      ),
      backgroundColor: const Color(0xFFE6E6FA),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              HistoryCard(
                title: "Kolam nila 1",
                data: ["1 autofeeder", "3kg", "pH = 7", "suhu = 27°C"],
              ),
              SizedBox(height: 10),
              HistoryCard(
                title: "Kolam nila 2",
                data: ["2 autofeeder", "3kg", "pH = 7", "suhu = 27°C"],
 
              ),
              SizedBox(height: 10),
              HistoryCard(
                title: "Kolam nila 3",
                data: ["2 autofeeder", "3kg", "pH = 7", "suhu = 27°C"],
   
              ),
              SizedBox(height: 10),
              HistoryCard(
                title: "Kolam nila 4",
                data: ["2 autofeeder", "3kg", "pH = 7", "suhu = 27°C"],
   
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final String title;
  final List<String> data;
  final Color textColor;
  final Color cardColor;

  const HistoryCard({
    super.key,
    required this.title,
    required this.data,
    this.textColor = const Color(0xFF37AFE1),
    this.cardColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: data
                    .map(
                      (item) => Row(
                        children: [
                          Text(
                            item,
                            style: const TextStyle(fontSize: 12),
                          ),
                          if (item != data.last) ...[
                            const SizedBox(width: 20),
                            const VerticalDivider(
                              thickness: 1,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 20),
                          ],
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
