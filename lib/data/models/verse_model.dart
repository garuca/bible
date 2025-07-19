import '../../domain/entities/verse.dart';

class VerseModel {
  final int bookId;
  final int chapter;
  final int verse;
  final String text;

  VerseModel({
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.text,
  });

  factory VerseModel.fromMap(Map<String, dynamic> map) {
    return VerseModel(
      bookId: map['book_id'] as int,
      chapter: map['chapter'] as int,
      verse: map['verse'] as int,
      text: map['text'] as String,
    );
  }

  Verse toEntity() =>
      Verse(bookId: bookId, chapter: chapter, verse: verse, text: text);
}