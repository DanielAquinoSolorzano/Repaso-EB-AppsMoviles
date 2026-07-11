class BookDto {
  final int id;
  final String title;
  final String author;
  final String cover;
  final String publisher;
  final int year;
  final double rating;
  final String genre;
  final String overview;
  final String? addedToReadListAt;

  BookDto({
    required this.id,
    required this.title,
    required this.author,
    required this.cover,
    required this.publisher,
    required this.year,
    required this.rating,
    required this.genre,
    required this.overview,
    required this.addedToReadListAt
  });

  factory BookDto.fromJson(Map<String, dynamic> json) {
    // Si el JSON viene anidado dentro de "book" (como suele pasar en endpoints de listas/relaciones)
    final bookData = json.containsKey('book') ? json['book'] as Map<String, dynamic> : json;

    return BookDto(
      id: bookData['id'] ?? bookData['bookId'] ?? 0,
      title: bookData['title'] ?? '',
      author: bookData['author'] ?? '',
      cover: bookData['cover'] ?? '',
      publisher: bookData['publisher'] ?? '',
      year: bookData['year'] ?? 0,
      rating: (bookData['rating'] ?? 0.0).toDouble(),
      genre: bookData['genre'] ?? '',
      overview: bookData['overview'] ?? '',
      addedToReadListAt: json['addedAt'] ?? bookData['addedAt'],
    );
  }
}