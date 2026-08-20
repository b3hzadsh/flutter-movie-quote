import 'package:persian_quote/domain/entities/quote.dart';

abstract class QuoteRepository {
  Future<List<QuoteItem>> getQuotesByMovie(String movieTitle);
  Future<QuoteItem?> getQuoteById(String id);
  Future<List<QuoteItem>> getAllQuotes();
  Future<QuoteItem> updateQuote(QuoteItem item);
  // Future<List<QuoteItem>> getNewQuotes();
  // Set<String> getAllRemoteIds();
  // Stream<List<QuoteItem>> watchAllItems();
  // Future<Either<Failure, List<Tag>>> getAllCategories();
  // Future<List<FeedSource>> getAllFeedSources();
  // Future<void> syncTagsFromJson(String jsonPath);
  // Stream<List<QuoteItem>> watchItemsByTags(String tagRemoteId);
  // Future<void> clearAllQuotes();
  // Stream<List<QuoteItem>> watchBookmarks();
  // Future<void> close();
  // List<QuoteItem> getAll();
  // Future<void> insertMany(List<QuoteItem> items);
}
