import 'package:flutter/cupertino.dart';

import 'app.dart';
import 'data/datasources/database_provider.dart';
import 'data/datasources/bible_local_data_source.dart';
import 'data/repositories/bible_repository_impl.dart';
import 'domain/usecases/get_books_use_case.dart';
import 'domain/usecases/get_verses_use_case.dart';
import 'domain/usecases/compare_verses_use_case.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbProvider = DatabaseProvider();
  await dbProvider.init();
  final localDataSource = BibleLocalDataSource(dbProvider);
  final repository = BibleRepositoryImpl(localDataSource);
  runApp(MyApp(
    getBooksUseCase: GetBooksUseCase(repository),
    getVersesUseCase: GetVersesUseCase(repository),
    compareVersesUseCase: CompareVersesUseCase(repository),
  ));
}