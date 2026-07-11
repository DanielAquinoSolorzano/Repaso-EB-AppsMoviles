import 'package:book_app/features/home/presentation/home_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:book_app/features/home/presentation/read_list/read_list_view_model.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({super.key, required this.bookId});
  final int bookId;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final readListViewModel = context.watch<ReadListViewModel>();

    // Buscamos el libro actual dentro del estado del ViewModel usando el ID
    final book = viewModel.state.books.firstWhere(
      (b) => b.id == bookId,
      orElse: () => throw Exception('Libro no encontrado'),
    );

    final bool isInReadList = readListViewModel.state.booksInReadList.any((b) => b.id == bookId);

    return Scaffold(
      appBar: AppBar(
        actions: [
          // Icono de corazón reactivo para Favoritos
          IconButton(
            icon: Icon(
              book.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () async {
              await viewModel.toggleFavorite(book.id, !book.isFavorite);

              if (context.mounted) {
                await context.read<HomeViewModel>().getBooks();
              }
            },
          ),
          // Icono para Lista de Lectura
          IconButton(
            icon: Icon(
              isInReadList ? Icons.bookmark : Icons.bookmark_add_outlined,
              color: isInReadList ? Colors.blue : null,
            ),
            onPressed: () async {
              await readListViewModel.toggleReadList(book.id);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Portada del Libro
              SizedBox(
                height:
                    280, // Aumentado un poco para que luzca mejor la portada
                width: double.infinity,
                child: Hero(
                  tag: book.id,
                  child: CachedNetworkImage(
                    imageUrl: book.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, size: 50),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // 2. Título del Libro
              Text(
                book.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // 3. Autor
              Text(
                'By ${book.author}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic,
                ),
              ),

              // 4. Calificación (Estrellas visuales)
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '${book.rating} / 5',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const Divider(),

              // 5. Ficha Técnica en Horizontal (Editorial, Año, Género)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMetaInfo('Publisher', book.publisher),
                  _buildMetaInfo('Year', book.year.toString()),
                  _buildMetaInfo('Genre', book.genre),
                ],
              ),

              const Divider(),

              // 6. Descripción
              const Text(
                'Overview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                book.overview,
                style: const TextStyle(fontSize: 15, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para mostrar la metadata de forma ordenada
  Widget _buildMetaInfo(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
