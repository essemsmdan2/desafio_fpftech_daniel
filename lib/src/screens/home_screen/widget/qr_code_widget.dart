import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../feed_screen/feed_screen.dart';

class QrCodeButton extends StatefulWidget {
  const QrCodeButton({super.key});

  @override
  State<QrCodeButton> createState() => _QrCodeButtonState();
}

class _QrCodeButtonState extends State<QrCodeButton> {
  String ticket = '';

  readCode() async {
    try {
      String code = await FlutterBarcodeScanner.scanBarcode("#FFFFFF", 'Cancel', false, ScanMode.QR);
      setState(() {
        ticket = code != '-1' ? code : '';
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FeedScreen(
                    subreddit: ticket,
                  )),
        );
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: readCode,
      child: const CircleAvatar(
        radius: 25,
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.qr_code,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
