part of 'pages.dart';

/// Implementation of Mobile Scanner example with simple configuration
class ScanQr extends StatefulWidget {
  /// Constructor for simple Mobile Scanner example
  const ScanQr({super.key});

  @override
  State<ScanQr> createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  Barcode? _barcode;

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              GoRouter.of(context).go('/home');
            },
            icon: const Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        title: const Text("Scan Device QR"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            onDetect: _handleBarcode,
          ),
        ],
      ),
    );
  }
}
