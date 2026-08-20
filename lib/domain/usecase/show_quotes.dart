import 'package:persian_quote/domain/entities/quote.dart';
import 'package:persian_quote/domain/repositories/quote_repository.dart'
    show QuoteRepository;

class GetProductsUseCase {
  final QuoteRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<QuoteItem>> call() async {
    final quotes = await repository.getAllQuotes();
    var filtered = quotes.where((q) => q.text != "");
    return filtered.toList();
  }
}
