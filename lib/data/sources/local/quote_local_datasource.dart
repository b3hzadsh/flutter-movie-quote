import 'package:persian_quote/data/sources/contract.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/quote_model.dart';

class QuoteLocalDataSourceImpl implements QuoteLocalDataSource {
  final Database _db;

  QuoteLocalDataSourceImpl(this._db);

  static const String _tableName = 'Dialoguetb';

  @override
  Future<List<QuoteModel>> fetchAllQuotes() async {
    final List<Map<String, Object?>> maps = await _db.query(_tableName);

    return maps.map((map) {
      return QuoteModel.fromMap(map.cast<String, dynamic>());
    }).toList();
  }

  @override
  Future<List<QuoteModel>> fetchQuotesByMovie(String movieTitle) async {
    final List<Map<String, Object?>> maps = await _db.query(
      _tableName,
      where: 'film = ?',
      whereArgs: [movieTitle],
    );

    return maps.map((map) {
      return QuoteModel.fromMap(map.cast<String, dynamic>());
    }).toList();
  }

  @override
  Future<QuoteModel> updateQuote(QuoteModel item) async {
    final db = _db;

    final affectedRows = await db.update(
      _tableName,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [int.tryParse(item.id)],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (affectedRows == 0) {
      throw Exception('Quote with id ${item.id} not found');
    }

    return item;
  }
}
