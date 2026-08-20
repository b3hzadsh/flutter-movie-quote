import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/quote_cubit.dart';
import '../cubits/theme_cubit.dart';
import '../widgets/quote_card.dart';

class NewsListPage extends StatefulWidget {
  final String title;
  final String? movieTitle;
  const NewsListPage({super.key, required this.title, this.movieTitle});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.movieTitle != null) {
        context.read<QuoteCubit>().loadByMovie(widget.movieTitle!);
      } else {
        context.read<QuoteCubit>().init();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuoteCubit, QuoteState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                centerTitle: true,
                title: Text(widget.title),
                actions: [
                  if (widget.movieTitle != null)
                    IconButton(
                      icon: const Icon(Icons.clear_all),
                      tooltip: 'نمایش همه',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const NewsListPage(title: 'جملات فیلم‌ها'),
                          ),
                        );
                      },
                    ),
                  BlocBuilder<ThemeCubit, ThemeMode>(
                    builder: (context, mode) {
                      return IconButton(
                        icon: Icon(
                          mode == ThemeMode.dark
                              ? Icons.light_mode
                              : Icons.dark_mode,
                        ),
                        onPressed: () =>
                            context.read<ThemeCubit>().toggleTheme(),
                      );
                    },
                  ),
                ],
              ),
              if (state.isLoading && state.items.isEmpty)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.error != null && state.items.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('خطا در دریافت اطلاعات: ${state.error}'),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                )
              else if (state.items.isEmpty)
                const SliverFillRemaining(
                  child: Center(child: Text('جمله ای یافت نشد')),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final item = state.paginatedItems[index];
                    return QuoteCard(
                      item: item,
                      onBookmarkToggle: () {
                        context.read<QuoteCubit>().toggleBookmark(item);
                      },
                    );
                  }, childCount: state.paginatedItems.length),
                ),
              if (state.items.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: state.hasPreviousPage
                              ? () => context.read<QuoteCubit>().previousPage()
                              : null,
                          icon: const Icon(Icons.chevron_left),
                          label: const Text('قبلی'),
                        ),
                        Text(
                          'صفحه ${state.currentPage + 1} از ${state.totalPages}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton.icon(
                          onPressed: state.hasNextPage
                              ? () => context.read<QuoteCubit>().nextPage()
                              : null,
                          icon: const Icon(Icons.chevron_right),
                          label: const Text('بعدی'),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
