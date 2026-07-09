import 'package:book_app/features/home/domain/book.dart';

abstract class BookRepository {
  
  Future<List<Book>> getBooks();

  Future<List<Book>> getFavorites();

  Future<void> toggleFavorite(int bookId, bool isFavorite);


}