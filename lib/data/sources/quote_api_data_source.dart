// import 'dart:convert' show jsonDecode;

// import 'package:http/http.dart' as http;
// import 'package:persian_quote/data/models/quote_model.dart' show QuoteModel;
// import 'package:persian_quote/data/sources/contract.dart';

// class MovieQuoteApiDataSource implements QuoteLocalDataSource {
//   final http.Client client;

//   MovieQuoteApiDataSource({required this.client});

//   static const String _url =
//       'https://movie-quotes-api.vercel.app/api/v1/quotes';

//   @override
//   Future<List<QuoteModel>> fetchAllQuotes() async {
//     final response = await client.get(Uri.parse(_url));

//     if (response.statusCode != 200) {
//       throw Exception('Failed to load quotes: ${response.statusCode}');
//     }

//     final decoded = jsonDecode(response.body);

//     if (decoded is List) {
//       return decoded.map((item) => _toQuoteModel(item)).toList();
//     }

//     if (decoded is Map<String, dynamic>) {
//       final items = decoded['quotes'] ?? decoded['data'] ?? decoded['results'];

//       if (items is List) {
//         return items.map((item) => _toQuoteModel(item)).toList();
//       }
//     }

//     throw Exception('Unexpected API response format');
//   }

//   QuoteModel _toQuoteModel(dynamic item) {
//     final map = item as Map<String, dynamic>;

//     final quoteText = (map['quote'] ?? map['text'] ?? map['content'] ?? '')
//         .toString();

//     final movieTitle =
//         (map['show'] ?? map['title'] ?? map['movie_title'] ?? 'Unknown')
//             .toString();

//     final characterName =
//         (map['role'] ?? map['character'] ?? map['character_name'] ?? 'Unknown')
//             .toString();

//     final idValue = (map['id'] ?? map['_id'] ?? quoteText.hashCode).toString();

//     return QuoteModel.fromMap({
//       'id': idValue,
//       'text': quoteText,
//       'movie_title': movieTitle,
//       'character_name': characterName,
//     });
//   }

//   @override
//   Future<List<QuoteModel>> fetchQuotesByMovie(String movieTitle) {
//     // TODO: implement fetchQuotesByMovie
//     throw UnimplementedError();
//   }

//   @override
//   Future<QuoteModel> updateQuote(QuoteModel model) {
//     // TODO: implement updateQuote
//     throw UnimplementedError();
//   }
// }
