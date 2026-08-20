import 'package:persian_quote/data/models/quote_model.dart' show QuoteModel;
import 'package:persian_quote/data/sources/contract.dart'
    show QuoteLocalDataSource;
import 'package:persian_quote/domain/entities/quote.dart';
import 'package:persian_quote/domain/repositories/quote_repository.dart'
    show QuoteRepository;

import '../../domain/repositories/quote_repository.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteLocalDataSource localDataSource;

  QuoteRepositoryImpl({required this.localDataSource});

  @override
  Future<List<QuoteItem>> getAllQuotes() async {
    try {
      final models = await localDataSource.fetchAllQuotes();
      return models.map((model) => _mapToEntity(model)).toList();
    } catch (e) {
      throw Exception('Error fetching quotes from database');
    }
  }

  @override
  Future<List<QuoteItem>> getQuotesByMovie(String movieTitle) async {
    final models = await localDataSource.fetchQuotesByMovie(movieTitle);
    return models.map((model) => _mapToEntity(model)).toList();
  }

  @override
  Future<QuoteItem?> getQuoteById(String id) {
    throw UnimplementedError();
  }

  QuoteItem _mapToEntity(QuoteModel model) {
    return QuoteItem(
      id: model.id,
      text: model.text,
      movieTitle: model.movieTitle,
      isBookmarked: model.isBookmarked,
    );
  }

  @override
  Future<QuoteItem> updateQuote(QuoteItem item) async {
    final model = QuoteModel(
      id: item.id,
      text: item.text,
      movieTitle: item.movieTitle,
      isBookmarked: item.isBookmarked,
    );

    final updatedModel = await localDataSource.updateQuote(model);
    return updatedModel;
  }
}
