import 'package:persian_quote/domain/entities/quote.dart';
import 'package:persian_quote/domain/repositories/quote_repository.dart'
    show QuoteRepository;

class ChangeQuoteParams {
  final QuoteItem quoteItem; //todo should be entity or model ?

  const ChangeQuoteParams({required this.quoteItem});
}

class ChangeQuoteUseCase {
  final QuoteRepository repository;
  ChangeQuoteUseCase(this.repository);

  Future<QuoteItem> call({required ChangeQuoteParams params}) async {
    return await repository.updateQuote(params.quoteItem);
  }
}
