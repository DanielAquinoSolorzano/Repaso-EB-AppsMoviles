import 'package:book_app/features/home/domain/book.dart';
import 'package:book_app/features/home/presentation/book_detail_page.dart';
import 'package:book_app/features/home/presentation/favorites/favorites_list_item.dart';
import 'package:flutter/material.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({super.key, required this.favorites});
  final List<Book> favorites;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: favorites.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.5, //Controla la proporción (Ancho / Alto)
        crossAxisSpacing: 4, // Espaciado horizontal entre tarjetas
        mainAxisSpacing: 4, // Espaciado vertical entre tarjetas
      ),
      itemBuilder: (context, index) {
        final favorite = favorites[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                // Pasamos el ID en lugar del objeto completo
                builder: (context) => BookDetailPage(bookId: favorite.id),
              ),
            );
          },

          child: FavoritesListItem(book: favorite),
        );
      },
    );
  }
}
