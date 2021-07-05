import 'package:flutter/cupertino.dart';
import 'package:flutter_qrscanner/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel?> scans = [];

  String tipo_seleccionado = 'http';

  Future<ScanModel> nuevo_scan(String valor) async {
    final nuevo_scan = new ScanModel(valor: valor);
    final id = await BDProvider.db.nuvoScanRaw(nuevo_scan);
    nuevo_scan.id = id;
    if (this.tipo_seleccionado == nuevo_scan.tipo) {
      this.scans.add(nuevo_scan);
    }

    notifyListeners();
    //this.cargarScanPorTipo(nuevo_scan.tipo);
    return nuevo_scan;
  }

  cargarScan() async {
    final scans = await BDProvider.db.getAllScan();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScanPorTipo(String tipo) async {
    final scans = await BDProvider.db.getScanByTipo(tipo);
    this.scans = [...scans];
    notifyListeners();
  }

  borrarTodo() async {
    await BDProvider.db.deleteAll();
    notifyListeners();
  }

  borrarTodoPorId(int id, String tipo) async {
    await BDProvider.db.deleteScan(id);
    this.cargarScanPorTipo(tipo);
  }
}
