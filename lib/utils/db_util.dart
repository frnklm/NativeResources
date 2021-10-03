import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  //Pega caminho do DB quando ele tiver sido criado
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    //Junta o DbPath com o places.db no caminho do arquivo
    return sql.openDatabase(
      path.join(
        path.join(dbPath, 'places.db'),
      ),
      //Sempre que rodar o DB pela primeira vez chamando onCreate
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    //Recebe o DB criado no método acima e insere os valores
    final db = await DbUtil.database();
    //conflictAlgorithm, caso haja conflito de informações já inseridas no DB e sobrepõe
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }
}
