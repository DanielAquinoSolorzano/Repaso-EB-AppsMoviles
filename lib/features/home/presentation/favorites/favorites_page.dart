import 'package:book_app/features/home/presentation/favorites/favorites_list.dart';
import 'package:book_app/features/home/presentation/favorites/favorites_state.dart';
import 'package:book_app/features/home/presentation/favorites/favorites_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {

    final FavoritesViewModel viewModel = context.watch<FavoritesViewModel>();
    final FavoritesState state = viewModel.state;


    if (viewModel.state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.state.errorMessage != null) {
      return Center(child: Text(state.errorMessage!));
    }

    if (viewModel.state.favorites.isEmpty) {
      return const Center(child: Text('No favorites books'));
    }

    return FavoritesList(books: state.favorites);
  }
}