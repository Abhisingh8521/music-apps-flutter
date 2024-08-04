
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../views/utils/app_constants/app_constants.dart';

class DatabaseHelper {
  static Database? _database;

  static get initDatabase async {
    if (_database != null) return _database;
    var directory = await getApplicationDocumentsDirectory();
    var path = "$directory/$mediaDatabase";
    _database = await openDatabase(path, version: 1, onCreate: _createTables);
    return _database;
  }

  static _createTables(Database db, int version) {
    db.execute('''CREATE TABLE ''');
  }
}
