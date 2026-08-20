import 'package:persian_quote/domain/entities/quote.dart';

class QuoteModel extends QuoteItem {
  QuoteModel({
    required super.id,
    required super.text,
    required super.movieTitle,
    required super.isBookmarked,
  });

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      id: map['id'].toString(),
      text: map['Dialogue'] ?? '',
      movieTitle: map['film'] ?? '',
      isBookmarked: map['bookmark'] == 1 || map['bookmark'] == true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': int.tryParse(id),
      'Dialogue': text,
      'film': movieTitle,
      'bookmark': isBookmarked ? 1 : 0,
    };
  }
}
