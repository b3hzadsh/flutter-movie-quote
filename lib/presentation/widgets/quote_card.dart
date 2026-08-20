import 'package:flutter/material.dart';
import 'package:persian_quote/domain/entities/quote.dart';

class QuoteCard extends StatelessWidget {
  final QuoteItem item;
  final VoidCallback onBookmarkToggle;

  const QuoteCard({
    super.key,
    required this.item,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.movieTitle,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    item.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    size: 20,
                    color: item.isBookmarked ? theme.colorScheme.primary : null,
                  ),
                  onPressed: onBookmarkToggle,
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                item.text,
                textDirection: TextDirection.rtl,
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
