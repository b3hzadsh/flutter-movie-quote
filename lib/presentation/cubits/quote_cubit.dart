import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_quote/domain/entities/quote.dart' show QuoteItem;
import 'package:persian_quote/domain/usecase/quote_update.dart'
    show ChangeQuoteParams, ChangeQuoteUseCase;
import 'package:persian_quote/domain/usecase/show_quotes.dart'
    show GetProductsUseCase;
import 'dart:async';
import '../../data/services/network_service.dart';

class QuoteState {
  final List<QuoteItem> items;
  final bool isLoading;
  final String? error;
  final bool isShowingBookmarks;

  QuoteState({
    required this.items,
    this.isLoading = false,
    this.error,
    this.isShowingBookmarks = false,
  });

  QuoteState copyWith({
    List<QuoteItem>? items,
    bool? isLoading,
    String? error,
    bool? isShowingBookmarks,
  }) {
    return QuoteState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isShowingBookmarks: isShowingBookmarks ?? this.isShowingBookmarks,
    );
  }
}

class QuoteCubit extends Cubit<QuoteState> {
  // final NetworkService networkService;
  final GetProductsUseCase getProductsUseCase;
  final ChangeQuoteUseCase changeQuoteUseCase;
  StreamSubscription? _subscription;

  QuoteCubit(
    this.changeQuoteUseCase,
    this.getProductsUseCase,
    // this.networkService,
  ) : super(QuoteState(items: []));

 Future<List<QuoteItem>> init() async {
    emit(state.copyWith(isLoading: true));
    try {
      final items = await getProductsUseCase();
      emit(state.copyWith(items: items, isLoading: false));
      return items;
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
      return [];
    }
  }

 Future<void> toggleBookmark(QuoteItem item) async {
    item.isBookmarked = !item.isBookmarked;
    await changeQuoteUseCase(params: ChangeQuoteParams(quoteItem: item));
    final updatedItems = state.items.map((e) {
      return e.id == item.id ? item : e;
    }).toList();
    emit(state.copyWith(items: updatedItems));
  }

  Future<void> sync() async {
    // todo: implement sync
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
