import 'package:book_app/features/home/domain/book.dart';

abstract class BookRepository {
  
  Future<List<Book>> getBooks();

  Future<List<Book>> getFavorites();

  Future<List<Book>> getBooksInReadList();

  Future<void> toggleFavorite(int bookId, bool isFavorite);

  Future<void> toggleReadList(int bookId);

}