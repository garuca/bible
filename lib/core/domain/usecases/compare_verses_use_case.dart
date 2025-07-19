import 'package:bible/core/domain/entities/verse.dart';
import 'package:bible/core/domain/entities/version.dart';
import 'package:bible/core/domain/repositories/bible_repository.dart';

class CompareVersesUseCase {
  final BibleRepository repository;

  CompareVersesUseCase(this.repository);

  Future<Map<Version, List<Verse>>> call(
    Version version1,
    Version version2,
    int bookId,
    int chapter,
  ) async {
    final list1 = await repository.getVerses(version1, bookId, chapter);
    final list2 = await repository.getVerses(version2, bookId, chapter);
    return {version1: list1, version2: list2};
  }
}