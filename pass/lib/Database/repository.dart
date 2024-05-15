import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:pass/Database/note.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class NotesRepository {
  static const _dbName = 'ppp.db';
  static const _tableName = 'pppp';

  static Future<Database> _database() async {
    sqfliteFfiInit();
    final dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, _dbName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, password TEXT, photo TEXT,username TEXT,information TEXT,time TEXT)', // Ensure 'createAt' is NOT NULL
        );
      },
      version: 1,
    );
  }

  static Future<void> insert({required Note note}) async {
    try {
      final db = await _database();
      await db.insert(
        _tableName,
        note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    // ignore: empty_catches
    } catch (error) {
    }
  }

  static Future<List<Note>> getNotes() async {
    final db = await _database();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'] as int,
        title: maps[i]['title'] as String,
        password: maps[i]['password'] as String,
        photo: maps[i]['photo'] as String,
        username: maps[i]['username'] as String,
        information: maps[i]['information'] as String,
        time: DateTime.parse(maps[i]['time']),
      );
    });
  }

  static Future<void> delete({required Note note}) async {
    final db = await _database();
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  static update({required Note note}) async {
    final db = await _database();
    await db.update(_tableName, note.toMap(),
        where: 'id = ?', whereArgs: [note.id]);
  }
}
