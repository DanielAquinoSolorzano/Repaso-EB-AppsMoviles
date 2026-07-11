import 'package:book_app/features/home/data/local/book_entity.dart';
import 'package:book_app/features/home/data/remote/book_dto.dart';
import 'package:book_app/features/home/domain/book.dart';

extension BookDtoMapper on BookDto {
  Book toDomain() {
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
      isFavorite: false,
      addedToReadListAt: addedToReadListAt
      
    );
  }
}

extension BookEntityMapper on BookEntity {
  Book toDomain() {
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
      isFavorite: isFavorite
    );
  }  
}

extension BookDomainMapper on Book {

  BookEntity toEntity() {
    return BookEntity(
       id: id,
       title: title,
       author: author,
       cover: cover,
       publisher: publisher,
       year: year,
       rating: rating,
       genre: genre,
       overview: overview,
       isFavorite: isFavorite
    );
 }
}