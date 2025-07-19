import '../entities/book.dart';
import '../entities/verse.dart';
import '../entities/version.dart';

abstract class BibleRepository {
  Future<List<Book>> getBooks(Version version);
  Future<List<Verse>> getVerses(
    Version version,
    int bookId,
    int chapter,
  );
}