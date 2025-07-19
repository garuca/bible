import 'package:bible/core/domain/entities/book.dart';
import 'package:bible/core/domain/entities/verse.dart';
import 'package:bible/core/domain/entities/version.dart';

abstract class BibleRepository {
  Future<List<Book>> getBooks(Version version);
  Future<List<Verse>> getVerses(
    Version version,
    int bookId,
    int chapter,
  );
}