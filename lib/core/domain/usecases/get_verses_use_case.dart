import 'package:bible/core/domain/entities/verse.dart';
import 'package:bible/core/domain/entities/version.dart';
import 'package:bible/core/domain/repositories/bible_repository.dart';

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