import 'package:book_app/features/home/data/local/book_dao.dart';
import 'package:book_app/features/home/data/mappers/book_mapper.dart';
import 'package:book_app/features/home/data/remote/book_service.dart';
import 'package:book_app/features/home/domain/book.dart';
import 'package:book_app/features/home/domain/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  
  final BookService service;
  final BookDao dao;

  const BookRepositoryImpl({required this.service, required this.dao});

  @override
  Future<List<Book>> getBooks() async {
    try {
      final dtos = await service.getBooks();
      final books = dtos.map((dto) => dto.toDomain()).toList();

      for (final book in books) {

       final storagedBook = await dao.getBookById(book.id);
       if(storagedBook != null){
        // This means that the book is in the local database
        // so we need to keep the status of "isFavorite"
        book.isFavorite = storagedBook.isFavorite;
       }

        await dao.insertBook(
          book.toEntity()
        );
      }

      return books;
    } catch (e) {
      final entities = await dao.getAllBooks();
      if (entities.isNotEmpty) {
        return entities
            .map((entity) => entity.toDomain()).toList();
      } else {
        throw Exception('Failed to load books');
      }
    }
  }

  @override
  Future<List<Book>> getFavorites() async {
    try {
      final entities = await dao.getAllFavorites();
      final books = entities.map((entity) => entity.toDomain()).toList();
      return books;

    } catch (e) {
      throw Exception('Failed to load favorites books');       
    }
  }
  
  @override
  Future<void> toggleFavorite(int bookId, bool isFavorite) {
    return dao.toggleFavorite(bookId, isFavorite);
  }
}