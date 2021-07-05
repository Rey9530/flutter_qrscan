import 'package:flutter/material.dart';
import 'package:flutter_qrscanner/pages/direcciones_page.dart';

import 'package:flutter_qrscanner/providers/iu_provider.dart';
import 'package:flutter_qrscanner/providers/scan_list_provider.dart';

import 'package:flutter_qrscanner/widgets/custom_navigationbar.dart';
import 'package:flutter_qrscanner/widgets/scan_buttom.dart';
import 'package:flutter_qrscanner/pages/mapas_page.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hitorial"),
        actions: [
          IconButton(
            onPressed: () {
              final scanListProvider =
                  Provider.of<ScanListProvider>(context, listen: false)
                      .borrarTodo();
            },
            icon: Icon(Icons.wrong_location_rounded),
          )
        ],
      ),
      body: _HomeBody(),
      bottomNavigationBar: CustomeNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providers = Provider.of<UiProvider>(context);
    final currentIndex = providers.selectedMenuOpt;

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScanPorTipo('geo');
        return MapasPage();
      case 1:
        scanListProvider.cargarScanPorTipo('http');
        return DireccionesPage();

      default:
        return DireccionesPage();
    }
  }
}
