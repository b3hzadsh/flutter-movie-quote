import 'package:persian_quote/data/models/quote_model.dart' show QuoteModel;

abstract class QuoteLocalDataSource {
  Future<List<QuoteModel>> fetchAllQuotes();
  Future<QuoteModel> updateQuote(QuoteModel model);
  Future<List<QuoteModel>> fetchQuotesByMovie(String movieTitle);
}
