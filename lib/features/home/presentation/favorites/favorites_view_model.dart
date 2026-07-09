import 'package:book_app/features/home/domain/book_repository.dart';
import 'package:book_app/features/home/presentation/favorites/favorites_state.dart';
import 'package:flutter/material.dart';

class FavoritesViewModel extends ChangeNotifier {
  FavoritesState state = const FavoritesState();
  final BookRepository repository;

  FavoritesViewModel({required this.repository}) {
    getFavorites();
  }

  Future<void> getFavorites() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final favorites = await repository.getFavorites();
      state = state.copyWith(favorites: favorites, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }

    notifyListeners();
  }

  Future<void> toggleFavorite(int bookId, bool isFavorite) async {
    try {
      final updatedFavorites = state.favorites.map((book) {
        if (book.id == bookId) {
          return book.copyWith(isFavorite: isFavorite);
        }
        return book;
      }).toList();

      state = state.copyWith(favorites: updatedFavorites);
      notifyListeners();

      await repository.toggleFavorite(bookId, isFavorite);
    } catch (e) {
      state = state.copyWith(errorMessage: "Failed to update favorites");
      notifyListeners();
    }
  }
}
