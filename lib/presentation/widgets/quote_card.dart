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
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 150),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Padding(
                padding: const EdgeInsets.all(2),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    item.text,
                    textDirection: TextDirection.rtl,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
