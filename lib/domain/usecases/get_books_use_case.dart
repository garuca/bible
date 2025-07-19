import '../entities/book.dart';
import '../entities/version.dart';
import '../repositories/bible_repository.dart';

class GetBooksUseCase {
  final BibleRepository repository;

  GetBooksUseCase(this.repository);

  Future<List<Book>> call(Version version) {
    return repository.getBooks(version);
  }
}