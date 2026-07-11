import 'package:book_app/features/home/domain/book.dart';

class ReadListState {
  final List<Book> booksInReadList;
  final bool isLoading;
  final String? errorMessage;

  const ReadListState({
    this.booksInReadList = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ReadListState copyWith({
    List<Book>? booksInReadList,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ReadListState(
      booksInReadList: booksInReadList ?? this.booksInReadList,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }  
}