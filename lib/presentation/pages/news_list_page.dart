import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/quote_cubit.dart';
import '../cubits/theme_cubit.dart';
import '../widgets/news_card.dart';

class NewsListPage extends StatefulWidget {
  final String title;
  const NewsListPage({super.key, required this.title});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuoteCubit>().init();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuoteCubit, QuoteState>(
      listenWhen: (previous, current) =>
          previous.error != current.error && current.error == 'NO_INTERNET',
      listener: (context, state) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('عدم اتصال به اینترنت'),
            content: const Text(
              'برای به‌روزرسانی اخبار نیاز به اتصال اینترنت دارید. لطفاً وضعیت شبکه خود را بررسی کنید.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('تایید'),
              ),
            ],
          ),
        );
      },
      child: BlocBuilder<QuoteCubit, QuoteState>(
        builder: (context, state) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () => context.read<QuoteCubit>().sync(),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    centerTitle: true,
                    title: Text(
                      widget.title,
                      // state.isShowingBookmarks
                      //     ? 'اخبار ذخیره شده'
                      //     : (state.selectedCategoryName ?? 'تازه‌ترین اخبار'),
                    ),
                    actions: [
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
                    // bottom: PreferredSize(
                    //   preferredSize: const Size.fromHeight(70),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: SearchBar(
                    //       controller: _searchController,
                    //       hintText: 'جستجو...',
                    //       onChanged: (value) =>
                    //           context.read<QuoteCubit>().search(value),
                    //       leading: const Icon(Icons.search),
                    //       trailing: [
                    //         if (_searchController.text.isNotEmpty)
                    //           IconButton(
                    //             icon: const Icon(Icons.clear),
                    //             onPressed: () {
                    //               setState(() {
                    //                 _searchController.clear();
                    //               });
                    //               context.read<QuoteCubit>().search('');
                    //             },
                    //           ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
                            ElevatedButton(
                              onPressed: () =>
                                  context.read<QuoteCubit>().sync(),
                              child: const Text('تلاش مجدد'),
                            ),
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
                        final item = state.items[index];
                        return QuoteCard(
                          item: item,
                          onBookmarkToggle: () {
                            context.read<QuoteCubit>().toggleBookmark(item);
                          },
                        );
                      }, childCount: state.items.length),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
