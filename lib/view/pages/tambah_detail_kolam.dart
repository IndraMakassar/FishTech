import 'package:flutter/material.dart';

class TambahDetail extends StatelessWidget {
  const TambahDetail({Key? key}) : super(key: key);

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
        title: const Text('Detail Kolam'),
        backgroundColor: const Color(0xFF42A5F5),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),
              const SizedBox(height: 24),
              _SectionWidget(
                title: 'Autofeeder',
                buttonText: '+ Tambah Autofeed',
                child: const ListTile(
                  title: Text(
                    'Autofeeder 1',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _SectionWidget(
                title: 'Sensor pH1',
                buttonText: '+ Tambah Sensor',
                child: const ListTile(
                  title: Text(
                    '1 Sensor pH',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('pH kolam = 7'),
                ),
              ),
              const SizedBox(height: 24),
              _SectionWidget(
                title: 'Sensor Suhu1',
                buttonText: '+ Tambah Sensor',
                child: const ListTile(
                  title: Text(
                    '2 Sensor suhu',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Suhu Kolam 27° C'),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF3F4FB),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kolam Nila 4',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Jenis Ikan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Ikan Nila'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Jumlah Pakan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('3kg'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Tanggal Budidaya',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('20 Des 2024'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionWidget extends StatelessWidget {
  final String title;
  final String buttonText;
  final Widget child;

  const _SectionWidget({
    Key? key,
    required this.title,
    required this.buttonText,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
              },
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Color(0xFF42A5F5), 
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }
}
