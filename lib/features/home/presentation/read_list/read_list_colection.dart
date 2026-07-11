import 'package:book_app/features/home/domain/book.dart';
import 'package:book_app/features/home/presentation/book_detail_page.dart';
import 'package:book_app/features/home/presentation/read_list/read_list_colection_item.dart';
import 'package:flutter/material.dart';

class ReadListColection extends StatelessWidget {
  const ReadListColection({super.key, required this.books});
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: books.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.5, // Controla la proporción (Ancho / Alto)
        crossAxisSpacing: 4, // Espaciado horizontal entre tarjetas
        mainAxisSpacing: 4, // Espaciado vertical entre tarjetas
      ),
      itemBuilder: (context, index) {
        final book = books[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                // Pasamos el ID en lugar del objeto completo
                builder: (context) => BookDetailPage(bookId: book.id),
              ),
            );
          },

          child: ReadListColectionItem(book: book),
        );
      },
    );
  }
}
