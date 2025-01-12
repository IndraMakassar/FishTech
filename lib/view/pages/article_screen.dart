import 'package:flutter/material.dart';
import 'package:fishtech/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ArticlePage(),
    );
  }
}

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  final colorScheme = MaterialTheme.lightScheme();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Artikel',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: const ArticleBody(),
    );
  }
}

class ArticleBody extends StatelessWidget {
  const ArticleBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background content (image)
        Image.asset(
          'gambar_ikan_nila.jpeg', // Replace with your asset path
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Text(
                "Gambar tidak ditemukan",
                style: TextStyle(color: Colors.red),
              ),
            );
          },
        ),

        // Draggable Modal Sheet
        const Align(
          alignment: Alignment.bottomCenter,
          child: DraggableDescriptionModal(),
        ),
      ],
    );
  }
}

class DraggableDescriptionModal extends StatelessWidget {
  const DraggableDescriptionModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final colorScheme = MaterialTheme.lightScheme();

    return DraggableScrollableSheet(
      initialChildSize: 0.4, 
      minChildSize: 0.4, 
      maxChildSize: 0.9, 
      expand: false, 
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer, 
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Ikan Nila',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Penyakit yang disebabkan jamur (cendawan) umumnya menyerang ikan air tawar pada kolam organik. Penyakit pada ikan lele ini tidak menyerang lele yang sehat namun hanya menyerang ikan yang sedang sakit atau terluka serta dalam kondisi lemah.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
