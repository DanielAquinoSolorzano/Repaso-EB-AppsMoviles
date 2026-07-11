import 'package:book_app/features/home/domain/book_repository.dart';
import 'package:book_app/features/home/presentation/read_list/read_list_state.dart';
import 'package:flutter/material.dart';

class ReadListViewModel extends ChangeNotifier {
  ReadListState state = const ReadListState();
  final BookRepository repository;

  ReadListViewModel({required this.repository}) {
    getBooksInReadList();
  }

  Future<void> getBooksInReadList() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final books = await repository.getBooksInReadList();
      state = state.copyWith(booksInReadList: books, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }

    notifyListeners();
  }

  Future<void> toggleFavorite(int bookId, bool isFavorite) async {
    try {
      final updatedBooks = state.booksInReadList.map((book) {
        if (book.id == bookId) {
          return book.copyWith(isFavorite: isFavorite);
        }
        return book;
      }).toList();

      state = state.copyWith(booksInReadList: updatedBooks);
      notifyListeners();

      await repository.toggleFavorite(bookId, isFavorite);
    } catch (e) {
      state = state.copyWith(errorMessage: "Unable to update book $bookId favorite status:");
      notifyListeners();
    }
  }

  Future<void> toggleReadList(int bookId) async {
    try {
      await repository.toggleReadList(bookId);
      await getBooksInReadList(); // Refresca la lista desde el servidor
    } catch (e) {
      state = state.copyWith(errorMessage: "Unable to update read list status for book $bookId");
      notifyListeners();
    }
  }
}
