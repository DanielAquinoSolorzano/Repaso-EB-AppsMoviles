import 'package:book_app/features/home/presentation/catalog/catalog_list.dart';
import 'package:book_app/features/home/presentation/home_state.dart';
import 'package:book_app/features/home/presentation/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {

    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final HomeState state = viewModel.state;


    if (viewModel.state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.state.errorMessage != null) {
      return Center(child: Text(state.errorMessage!));
    }

    return CatalogList(books: state.books);
  }
}