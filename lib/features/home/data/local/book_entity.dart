class BookEntity {
  final int id;
  final String title;
  final String author;
  final String cover;
  final String publisher;
  final int year;
  final double rating;
  final String genre;
  final String overview;
  final bool isFavorite;

  const BookEntity({
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'cover': cover,
      'publisher': publisher,
      'year': year,
      'rating': rating,
      'genre': genre,
      'overview': overview,
      'is_favorite': isFavorite ? 1 : 0,
    };
  }

  factory BookEntity.fromMap(Map<String, dynamic> map) {
    return BookEntity(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      cover: map['cover'],
      publisher: map['publisher'],
      year: map['year'],
      rating: map['rating'],
      genre: map['genre'],
      overview: map['overview'],
      isFavorite: map['is_favorite'] == 1,
    );
  }
}