import 'package:bible/core/domain/entities/book.dart';

class BookModel {
  final int id;
  final String name;
  final int number;

  BookModel({required this.id, required this.name, required this.number});

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'] as int,
      name: map['name'] as String,
      number: map['book_reference_id'] as int,
    );
  }

  Book toEntity() => Book(id: id, name: name, number: number);
}