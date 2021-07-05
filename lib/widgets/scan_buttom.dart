import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_qrscanner/providers/scan_list_provider.dart';
import 'package:flutter_qrscanner/utils/utils.dart';
import 'package:provider/provider.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        String barcodeScaner = await FlutterBarcodeScanner.scanBarcode(
            '#3DBBEF', 'Cancelar', false, ScanMode.QR);
        //final barcodeScaner = 'https://medicprosv.app/saludsura/';
        //final barcodeScaner = 'geo:13.721252, -89.236980';
        if (barcodeScaner == '-') return;
        final scanlisProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        final nuevo_scan = await scanlisProvider.nuevo_scan(barcodeScaner);
        launchURL(context, nuevo_scan);
      },
    );
  }
}
