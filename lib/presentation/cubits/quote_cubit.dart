import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_quote/domain/entities/quote.dart' show QuoteItem;
import 'package:persian_quote/domain/usecase/quote_update.dart'
    show ChangeQuoteParams, ChangeQuoteUseCase;
import 'package:persian_quote/domain/usecase/show_quotes.dart'
    show GetProductsUseCase;
import 'dart:async';

class QuoteState {
  final List<QuoteItem> items;
  final int currentPage;
  final int itemsPerPage;
  final bool isLoading;
  final String? error;
  final bool isShowingBookmarks;

  QuoteState({
    required this.items,
    this.currentPage = 0,
    this.itemsPerPage = 30,
    this.isLoading = false,
    this.error,
    this.isShowingBookmarks = false,
  });

  QuoteState copyWith({
    List<QuoteItem>? items,
    int? currentPage,
    int? itemsPerPage,
    bool? isLoading,
    String? error,
    bool? isShowingBookmarks,
  }) {
    return QuoteState(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isShowingBookmarks: isShowingBookmarks ?? this.isShowingBookmarks,
    );
  }

  List<QuoteItem> get paginatedItems {
    final start = currentPage * itemsPerPage;
    if (start >= items.length) return [];
    final end = (start + itemsPerPage).clamp(0, items.length);
    return items.sublist(start, end);
  }

  int get totalPages {
    if (items.isEmpty) return 1;
    return (items.length / itemsPerPage).ceil();
  }

  bool get hasNextPage => currentPage + 1 < totalPages;
  bool get hasPreviousPage => currentPage > 0;
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

  void goToPage(int page) {
    if (page < 0 || page >= state.totalPages) return;
    emit(state.copyWith(currentPage: page));
  }

  void nextPage() => goToPage(state.currentPage + 1);
  void previousPage() => goToPage(state.currentPage - 1);

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


  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
