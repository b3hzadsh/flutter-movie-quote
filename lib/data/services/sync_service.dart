// import 'package:flutter/foundation.dart';
// import '../sources/rss_data_source.dart';
// import '../../domain/repositories/news_storage.dart';
// import '../../domain/entities/news_item.dart';

// class SyncService {
//   final RssDataSource dataSource;
//   final NewsStorage db;

//   SyncService(
//     this.dataSource,
//     this.db,
//   );

//   Future<void> sync(bool isIranianIp) async {
//     // 1. Cleanup old news
//     final cutoff = DateTime.now().subtract(const Duration(days: 30));
//     await db.deleteOldNews(cutoff);

//     // 2. Fetch all feed sources
//     final allFeeds = await db.getAllFeedSources();
//     final activeFeeds = allFeeds.where((f) {
//       // If in Iran, keep only local feeds. If outside, keep only global feeds.
//       return f.isLocalOnly == isIranianIp;
//     }).toList();
    
//     debugPrint('isIranianIp: $isIranianIp');
//     debugPrint('Total feeds: ${allFeeds.length}');
//     debugPrint('Active feeds: ${activeFeeds.length}');
//     for (var f in activeFeeds) {
//       debugPrint('Active feed: ${f.name}, isLocalOnly: ${f.isLocalOnly}');
//     }

//     if (activeFeeds.isEmpty) return;

//     final List<NewsItem> allNewItems = [];
//     final existingRemoteIds = db.getAllRemoteIds();

//     for (final feed in activeFeeds) {
//       try {
//         final items = await dataSource.fetchFeed(feed.url, feed.name);
        
//         for (final item in items) {
//           if (existingRemoteIds.add(item.remoteId)) {
//             item.feed.target = feed;
//             allNewItems.add(item);
//           }
//         }
//       } catch (e) {
//         debugPrint('Error fetching feed for ${feed.name}: $e');
//       }
//     }

//     if (allNewItems.isNotEmpty) {
//       await db.insertMany(allNewItems);
//       debugPrint('Synced ${allNewItems.length} new items across ${activeFeeds.length} feeds');
//     }
//   }
// }
