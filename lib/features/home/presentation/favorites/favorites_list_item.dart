import 'package:book_app/features/home/domain/book.dart';
import 'package:book_app/features/home/presentation/favorites/favorites_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesListItem extends StatelessWidget {
  final Book book;
  const FavoritesListItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el viewModel de favoritos sin escuchar cambios aquí (read)
    // porque el GridView principal ya se redibuja mediante el Page
    final favoritesViewModel = context.watch<FavoritesViewModel>();

    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de Portada
            Expanded(
              child: Hero(
                tag: book.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: book.cover,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Título del libro
            Text(
              book.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            // Autor y Fila de Acción (Quitar Favorito)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[700], fontSize: 13),
                  ),
                ),
                // Botón directo para eliminar de favoritos
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.favorite, color: Colors.red, size: 22),
                  onPressed: () async {
                    // LLamamos al método para remover (puedes reusar toggleFavorite si tu repositorio lo maneja así)
                    await favoritesViewModel.toggleFavorite(book.id, !book.isFavorite);

                    if (context.mounted) {
                      await context.read<FavoritesViewModel>().getFavorites();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
