import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:pass/Database/note.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

// ignore: camel_case_types
class lockDb {
  static const _dbName = 'lockdb.db';
  static const _tableName = 'locktb';

  static Future<Database> _database() async {
    sqfliteFfiInit();
    final dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, _dbName),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, password TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insertlock({required Lock lock}) async {
    try {
      final db = await _database();
      await db.insert(
        _tableName,
        lock.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    // ignore: empty_catches
    } catch (error) {
    }
  }

  static Future<List<Lock>> getlock() async {
    final db = await _database();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return Lock(
        id: maps[i]['id'] as int,
        password: maps[i]['password'] as String,
      );
    });
  }

  static updatelock({required Lock lock}) async {
    final db = await _database();
    await db.update(_tableName, lock.toMap(),
        where: 'id = ?', whereArgs: [lock.id]);
  }
}
