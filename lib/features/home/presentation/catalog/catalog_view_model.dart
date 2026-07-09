import 'package:book_app/features/home/domain/book_repository.dart';
import 'package:book_app/features/home/presentation/catalog/catalog_state.dart';
import 'package:flutter/material.dart';

class CatalogViewModel extends ChangeNotifier {
  CatalogState state = const CatalogState();
  final BookRepository repository;

  CatalogViewModel({required this.repository}) {
    getBooks();
  }

  Future<void> getBooks() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final books = await repository.getBooks();
      state = state.copyWith(books: books, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }

    notifyListeners();
  }

  Future<void> toggleFavorite(int bookId, bool isFavorite) async {
    try {
      final updatedBooks = state.books.map((book) {
        if (book.id == bookId) {
          return book.copyWith(isFavorite: isFavorite);
        }
        return book;
      }).toList();

      state = state.copyWith(books: updatedBooks);
      notifyListeners();

      await repository.toggleFavorite(bookId, isFavorite);
    } catch (e) {
      state = state.copyWith(errorMessage: "No se pudo actualizar favoritos");
      notifyListeners();
    }
  }
}
