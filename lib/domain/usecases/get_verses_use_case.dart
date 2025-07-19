import '../entities/verse.dart';
import '../entities/version.dart';
import '../repositories/bible_repository.dart';

class GetVersesUseCase {
  final BibleRepository repository;

  GetVersesUseCase(this.repository);

  Future<List<Verse>> call(
    Version version,
    int bookId,
    int chapter,
  ) {
    return repository.getVerses(version, bookId, chapter);
  }
}