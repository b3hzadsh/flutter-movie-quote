// import 'package:flutter_test/flutter_test.dart';
// import 'package:sqflite_common_ffi/sqflite_common_ffi.dart';
// import 'package:persian_quote/data/sources/local/quote_local_datasource.dart';
// import 'package:sqflite/sqflite.dart' show Database;

// void main() {
//   late Database database;
//   late QuoteLocalDataSourceImpl dataSource;

//   setUpAll(() async {
//     sqfliteFfiInit();
//     database = await databaseFactoryFfi.openDatabase(
//       r'C:\Users\Eniac\Documents\dev\flutter-quote\assets\db\dialogue.db',
//     );
//     dataSource = QuoteLocalDataSourceImpl(database);
//   });

//   tearDownAll(() async {
//     await database.close();
//   });

//   test('fetch first quote from Dialoguetb and print it', () async {
//     final quotes = await dataSource.fetchAllQuotes();
//     expect(quotes, isNotEmpty);

//     final first = quotes.first;
//     print('=== First Quote ===');
//     print('ID: ${first.id}');
//     print('Film: ${first.movieTitle}');
//     print('Dialogue: ${first.text}');
//     print('Bookmark: ${first.isBookmarked}');
//     print('===================');
//   });
// }
