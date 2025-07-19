import 'package:sqflite/sqflite.dart';

import '../../domain/entities/book.dart';
import '../../domain/entities/verse.dart';
import '../../domain/entities/version.dart';
import 'database_provider.dart';
import '../models/book_model.dart';
import '../models/verse_model.dart';

class BibleLocalDataSource {
  final DatabaseProvider provider;

  BibleLocalDataSource(this.provider);

  Future<List<Book>> getBooks(Version version) async {
    final db = _getDb(version);
    final result = await db.query('book', orderBy: 'book_reference_id');
    return result.map((e) => BookModel.fromMap(e).toEntity()).toList();
  }

  Future<List<Verse>> getVerses(
    Version version,
    int bookId,
    int chapter,
  ) async {
    final db = _getDb(version);
    final result = await db.query(
      'verse',
      where: 'book_id = ? AND chapter = ?',
      whereArgs: [bookId, chapter],
      orderBy: 'verse',
    );
    return result.map((e) => VerseModel.fromMap(e).toEntity()).toList();
  }

  Database _getDb(Version version) {
    switch (version) {
      case Version.KJA:
        return provider.dbKJA;
      case Version.KJF:
        return provider.dbKJF;
    }
  }
}