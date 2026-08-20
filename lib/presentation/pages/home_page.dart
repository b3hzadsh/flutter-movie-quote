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
          backgroundColor: color.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
