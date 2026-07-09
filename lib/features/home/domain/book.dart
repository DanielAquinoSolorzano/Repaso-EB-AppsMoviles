class Book {
  final int id;
  final String title;
  final String author;
  final String cover;
  final String publisher;
  final int year;
  final double rating;
  final String genre;
  final String overview;
  bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.cover,
    required this.publisher,
    required this.year,
    required this.rating,
    required this.genre,
    required this.overview,
    required this.isFavorite,
  });

  Book copyWith({bool? isFavorite}) {
    return Book(
      id: id,
      title: title,
      author: author,
      cover: cover,
      publisher: publisher,
      year: year,
      rating: rating,
      genre: genre,
      overview: overview,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}