import 'package:flutter/cupertino.dart';
import 'package:flutter_qrscanner/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext contex, ScanModel scan) async {
  final url = scan.valor;
  if (scan.tipo == 'http') {
    final is_valid = await canLaunch(url);
    if (is_valid) {
      await launch(url);
    } else {
      //throw 'Could not launch $_url';
      print('Could not launch $url');
    }
  } else {
    Navigator.pushNamed(contex, 'maps', arguments: scan);
  }
}
