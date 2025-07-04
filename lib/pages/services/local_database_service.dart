import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_application_laboratorio_3/pages/domain/entities/user_feedback.dart';

class LocalDatabaseService {
  static Database? _database;

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'dinoverse_feedback.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE feedback (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId TEXT,
            usabilidad TEXT,
            contenido TEXT,
            compartir TEXT
          )
        ''');
      },
    );
  }

  static Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  static Future<void> insertFeedback(UserFeedback feedback) async {
    final db = await database;
    await db.insert(
      'feedback',
      feedback.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getAllFeedback() async {
    final db = await database;
    return await db.query('feedback');
  }

  static Future<void> clearFeedback() async {
    final db = await database;
    await db.delete('feedback');
  }
}
