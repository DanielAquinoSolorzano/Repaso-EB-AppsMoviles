import 'package:book_app/features/home/domain/book.dart';

class FavoritesState {
  final List<Book> favorites;
  final bool isLoading;
  final String? errorMessage;

  const FavoritesState({
    this.favorites = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  FavoritesState copyWith({
    List<Book>? favorites,
    bool? isLoading,
    String? errorMessage,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }  
}