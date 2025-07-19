import '../../domain/entities/book.dart';
import '../../domain/entities/verse.dart';
import '../../domain/entities/version.dart';
import '../../domain/repositories/bible_repository.dart';
import '../datasources/bible_local_data_source.dart';

class BibleRepositoryImpl implements BibleRepository {
  final BibleLocalDataSource localDataSource;

  BibleRepositoryImpl(this.localDataSource);

  @override
  Future<List<Book>> getBooks(Version version) {
    return localDataSource.getBooks(version);
  }

  @override
  Future<List<Verse>> getVerses(
    Version version,
    int bookId,
    int chapter,
  ) {
    return localDataSource.getVerses(version, bookId, chapter);
  }
}