import 'package:book_app/features/home/domain/book.dart';
import 'package:book_app/features/home/presentation/favorites/favorites_list.dart';
import 'package:book_app/features/home/presentation/home_state.dart';
import 'package:book_app/features/home/presentation/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {

    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final HomeState state = viewModel.state;
    final List<Book> favorites = state.books.where((book) => book.isFavorite).toList();

    if (viewModel.state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.state.errorMessage != null) {
      return Center(child: Text(state.errorMessage!));
    }

    if (favorites.isEmpty) {
      return const Center(child: Text('No favorites books'));
    }

    return FavoritesList(favorites: favorites);
  }
}