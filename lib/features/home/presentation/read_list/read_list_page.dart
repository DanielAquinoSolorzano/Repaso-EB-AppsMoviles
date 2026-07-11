import 'package:book_app/features/home/domain/book.dart';
import 'package:book_app/features/home/presentation/read_list/read_list_colection.dart';
import 'package:book_app/features/home/presentation/read_list/read_list_state.dart';
import 'package:book_app/features/home/presentation/read_list/read_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadListPage extends StatelessWidget {
  const ReadListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ReadListViewModel viewModel = context.watch<ReadListViewModel>();
    final ReadListState state = viewModel.state;
    final List<Book> booksInReadList = state.booksInReadList;

    if (viewModel.state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.state.errorMessage != null) {
      return Center(child: Text(state.errorMessage!));
    }

    if (booksInReadList.isEmpty) {
      return const Center(
        child: Text(
          'No books in Read List',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );
    }

    return ReadListColection(books: booksInReadList);
  }
}