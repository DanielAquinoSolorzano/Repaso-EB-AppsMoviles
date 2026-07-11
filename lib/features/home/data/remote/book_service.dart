import 'dart:convert';
import 'dart:io';

import 'package:book_app/core/storage/token_storage.dart';
import 'package:book_app/features/home/data/remote/book_dto.dart';
import 'package:http/http.dart' as http;

class BookService {
  final TokenStorage storage;
  final baseUrl =
      "https://bookapp-gveteaa0dqf0eycn.eastus-01.azurewebsites.net/api/";
  final booksEndpoint = "books";
  final readListsEndpoint = "readlists";

  const BookService({required this.storage});

  Future<List<BookDto>> getBooks() async {
    final response = await http.get(Uri.parse("$baseUrl$booksEndpoint"));

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);
      final List jsons = json["results"];
      return jsons.map((e) => BookDto.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load books");
    }
  }

  Future<List<BookDto>> getBooksInReadList() async {

    final String? token = await storage.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse("$baseUrl$readListsEndpoint"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $token',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);
      final List jsons = json["results"];
      return jsons.map((e) => BookDto.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load books in read list.");
    }
  }

  Future<void> toggleReadList(int bookId) async {
    final String? token = await storage.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.post(
      Uri.parse("$baseUrl$readListsEndpoint"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"bookId": bookId}),
    );

    if (response.statusCode != HttpStatus.ok && response.statusCode != HttpStatus.created) {
      throw Exception("Failed to toggle book in read list.");
    }
  }
}
