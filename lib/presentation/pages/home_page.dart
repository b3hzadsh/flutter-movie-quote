import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show exit;
import 'package:persian_quote/presentation/pages/bookmark_page.dart';
import 'package:persian_quote/presentation/pages/news_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.auto_stories,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'جملات فیلم‌ها',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'مجموعه‌ای از جملات ماندگار سینما',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'دسته‌بندی بر اساس فیلم',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                _MovieButton(
                  label: 'بازی تاج‌وتخت (Game of Thrones)',
                  count: 45,
                  onTap: () => _openMovie(context, 'Game of Thrones '),
                ),
                _MovieButton(
                  label: 'شوالیه تاریکی (The Dark Knight)',
                  count: 32,
                  onTap: () => _openMovie(context, 'The Dark Knight (2008)'),
                ),
                _MovieButton(
                  label: 'باب اسفنجی (SpongeBob)',
                  count: 31,
                  onTap: () => _openMovie(context, 'SpongeBob SquarePants '),
                ),
                _MovieButton(
                  label: 'نظریه بیگ بنگ (The Big Bang Theory)',
                  count: 28,
                  onTap: () => _openMovie(context, 'The Big Bang Theory '),
                ),
                _MovieButton(
                  label: 'مارمولک',
                  count: 22,
                  onTap: () => _openMovie(context, 'Marmoulak (2004)'),
                ),
                _MovieButton(
                  label: 'کارآگاه حقیقی (True Detective)',
                  count: 21,
                  onTap: () => _openMovie(context, 'True Detective '),
                ),
                _MovieButton(
                  label: 'بریکینگ بد (Breaking Bad)',
                  count: 16,
                  onTap: () => _openMovie(context, 'Breaking Bad '),
                ),
                _MovieButton(
                  label: 'رستگاری در شاوشنگ (Shawshank)',
                  count: 15,
                  onTap: () => _openMovie(context, 'The Shawshank Redemption (1994)'),
                ),
                _MovieButton(
                  label: 'باشگاه مبارزه (Fight Club)',
                  count: 15,
                  onTap: () => _openMovie(context, 'Fight Club (1999)'),
                ),
                _MovieButton(
                  label: 'بین‌ستاره‌ای (Interstellar)',
                  count: 13,
                  onTap: () => _openMovie(context, 'Interstellar (2014)'),
                ),
                const SizedBox(height: 48),
                _MenuButton(
                  icon: Icons.format_quote,
                  label: 'نمایش تمام جملات',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const NewsListPage(title: 'جملات فیلم‌ها'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _MenuButton(
                  icon: Icons.bookmark,
                  label: 'نشانک‌ها',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BookmarkPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _MenuButton(
                  icon: Icons.info_outline,
                  label: 'درباره',
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'جملات فیلم‌ها',
                      applicationVersion: '1.0.0',
                      applicationLegalese: '© 2024',
                      children: [
                        const Text('مجموعه‌ای از جملات ماندگار فیلم‌های سینما'),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 12),
                _MenuButton(
                  icon: Icons.exit_to_app,
                  label: 'خروج',
                  isDestructive: true,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('خروج'),
                        content: const Text('آیا مایل به خروج هستید؟'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('خیر'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              try {
                                SystemNavigator.pop();
                              } catch (_) {
                                exit(0);
                              }
                            },
                            child: const Text('بله'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openMovie(BuildContext context, String movieTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewsListPage(
          title: movieTitle.trim(),
          movieTitle: movieTitle,
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isDestructive
        ? theme.colorScheme.error
        : theme.colorScheme.primary;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label, style: const TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: color.withValues(alpha: 0.1),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class _MovieButton extends StatelessWidget {
  final String label;
  final int count;
  final VoidCallback onTap;

  const _MovieButton({
    required this.label,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.movie_outlined,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
