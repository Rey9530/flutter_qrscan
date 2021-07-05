// @dart=2.9
import 'package:flutter/material.dart';

import 'package:flutter_qrscanner/pages/home_page.dart';
import 'package:flutter_qrscanner/pages/maps_page.dart';
import 'package:flutter_qrscanner/providers/iu_provider.dart';
import 'package:flutter_qrscanner/providers/scan_list_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvider()),
        ChangeNotifierProvider(create: (_) => new ScanListProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Scanner',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomeScreen(),
          'maps': (_) => MapsScreen(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
