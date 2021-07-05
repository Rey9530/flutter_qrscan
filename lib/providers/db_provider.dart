import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_qrscanner/models/scan_model.dart';
export 'package:flutter_qrscanner/models/scan_model.dart';

class BDProvider {
  BDProvider._();
  static final BDProvider db = BDProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database?> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'scann.db');
    print(path);
    return await openDatabase(path, version: 5, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tipo TEXT,
            valor TEXT
          )
        ''');
  }

  Future<int> nuvoScan(ScanModel nuevoSacn) async {
    final db = await database;
    final resp = await db!.insert('Scans', nuevoSacn.toJson());
    return resp;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final resp = await db!.query('Scans', where: 'id=?', whereArgs: [id]);
    return resp.isNotEmpty ? ScanModel.fromJson(resp.first) : null;
  }

  Future<List<ScanModel?>> getScanByTipo2(String tipo) async {
    final db = await database;
    final resp = await db!.query('Scans', where: 'tipo=?', whereArgs: [tipo]);
    if (resp.isNotEmpty) {
      return resp.map((e) => ScanModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<ScanModel?>> getScanByTipo(String tipo) async {
    final db = await database;
    final res = await db!.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'    
    ''');
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<List<ScanModel?>> getAllScan() async {
    final db = await database;
    final resp = await db!.query('Scans');
    if (resp.isNotEmpty) {
      return resp.map((e) => ScanModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  // Actualizar Registros
  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db!.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  // Eliminar registros
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db!.rawDelete('DELETE FROM Scans');
    return res;
  }

  Future<int> nuvoScanRaw(ScanModel nuevoSacn) async {
    final db = await database;
    final value = nuevoSacn.valor;
    final tipo = nuevoSacn.tipo;
    final sql = '''
    INSERT INTO Scans(valor,tipo) VALUES( '$value','$tipo')
    ''';
    final resp = await db!.rawInsert(sql);
    return resp;
  }
}
