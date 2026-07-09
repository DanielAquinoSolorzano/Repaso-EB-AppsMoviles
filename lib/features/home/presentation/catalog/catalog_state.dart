import 'package:book_app/features/home/domain/book.dart';

class CatalogState {
  final List<Book> books;
  final bool isLoading;
  final String? errorMessage;

  const CatalogState({
    this.books = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  CatalogState copyWith({
    List<Book>? books,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CatalogState(
      books: books ?? this.books,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }  
}