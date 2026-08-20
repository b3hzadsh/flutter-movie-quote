import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_quote/presentation/cubits/quote_cubit.dart';
import 'package:persian_quote/presentation/widgets/quote_card.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuoteCubit>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuoteCubit, QuoteState>(
      builder: (context, state) {
        final bookmarked = state.items.where((i) => i.isBookmarked).toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('نشانک‌ها'),
          ),
          body: state.isLoading && state.items.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : bookmarked.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bookmark_border,
                            size: 64,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'نشانکی وجود ندارد',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: bookmarked.length,
                      itemBuilder: (context, index) {
                        final item = bookmarked[index];
                        return QuoteCard(
                          item: item,
                          onBookmarkToggle: () {
                            context.read<QuoteCubit>().toggleBookmark(item);
                          },
                        );
                      },
                    ),
        );
      },
    );
  }
}
