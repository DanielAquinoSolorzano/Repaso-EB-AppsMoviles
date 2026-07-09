import 'package:book_app/core/database/app_database.dart';
import 'package:book_app/features/home/data/local/book_entity.dart';
import 'package:sqflite/sqlite_api.dart';

class BookDao {
  final AppDatabase appDatabase;
  const BookDao({required this.appDatabase});

  Future<void> insertBook(BookEntity entity) async {
    final Database db = await appDatabase.database;
    await db.insert('books', entity.toMap());
  }

  Future<void> deleteAllBooks() async {
    final Database db = await appDatabase.database;
    await db.delete('books');
  }

  Future<List<BookEntity>> getAllBooks() async {
    final Database db = await appDatabase.database;
    final List maps = await db.query('books');

    return maps.map((map) => BookEntity.fromMap(map)).toList();
  }

  Future<List<BookEntity>> getAllFavorites() async {
    final Database db = await appDatabase.database;
    final List maps = await db.query(
      'books',
      where: 'is_favorite = 1',  
    );
    return maps.map((map) => BookEntity.fromMap(map)).toList();
  }

  Future<BookEntity?> getBookById(int id) async {
    final Database db = await appDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return BookEntity.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<void> toggleFavorite(int bookId, bool isFavorite) async {
    final Database db = await appDatabase.database;
    await db.update(
      'books',
      {'is_favorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [bookId],
    );
  }
}
