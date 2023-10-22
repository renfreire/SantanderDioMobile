import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ConexaoDb {
  static const _databaseName = "databaseimc.db";
  static const _databaseVersion = 1;
  static const _tabela = 'Historico';
  late Database _db;

  Future<Database> inicializarBD() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
    return _db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_tabela (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            usuario TEXT NOT NULL,
            horarioCalculo TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            peso TEXT NOT NULL,
            altura TEXT NOT NULL,
            resultado TEXT NOT NULL,
            descricao TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    return await _db.insert(_tabela, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db.query(_tabela);
  }

  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $_tabela');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> update(Map<String, dynamic> row) async {
    int id = row['id'];
    return await _db.update(
      _tabela,
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    return await _db.delete(
      _tabela,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
