import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database as Database;
    _database = await _initDatabase();
    return _database as Database;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'books.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE books (
            id INTEGER PRIMARY KEY,
            title TEXT,
            author TEXT,
            cover TEXT,
            publisher TEXT,
            year INTEGER,
            rating REAL,
            genre TEXT,
            overview TEXT,
            is_favorite INTEGER
          )
     ''');
      },
    );
  }
}
