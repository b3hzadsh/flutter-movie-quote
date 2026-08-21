import 'package:persian_quote/data/models/quote_model.dart';
import 'package:persian_quote/data/sources/contract.dart' show QuoteLocalDataSource;

class QuoteLocalDataSourceDevImpl implements QuoteLocalDataSource {
  final List<QuoteModel> _quotes = _generateLoremQuotes();

  @override
  Future<List<QuoteModel>> fetchAllQuotes() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _quotes;
  }

  @override
  Future<List<QuoteModel>> fetchQuotesByMovie(String movieTitle) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _quotes.where((q) => q.movieTitle == movieTitle).toList();
  }

  @override
  Future<QuoteModel> updateQuote(QuoteModel item) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final index = _quotes.indexWhere((q) => q.id == item.id);
    if (index == -1) throw Exception('Quote with id ${item.id} not found');
    _quotes[index] = item;
    return item;
  }

  static List<QuoteModel> _generateLoremQuotes() {
    final texts = [
      ('لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ', 'فیلم آزمایشی ۱'),
      ('و با استفاده از طراحان گرافیک است چاپگرها و متون بلکه روزنامه', 'فیلم آزمایشی ۱'),
      ('مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی', 'فیلم آزمایشی ۲'),
      ('تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی', 'فیلم آزمایشی ۲'),
      ('می باشد کتابهای زیادی در شصت و سه درصد گذشته حال و آینده', 'فیلم آزمایشی ۲'),
      ('شناخت فراوان جامعه و متخصصان را می طلبد', 'فیلم آزمایشی ۳'),
      ('تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای', 'فیلم آزمایشی ۳'),
      ('علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد', 'فیلم آزمایشی ۳'),
      ('در این صورت می توان امید داشت که تمام و دشواری موجود', 'فیلم آزمایشی ۴'),
      ('در ارائه راهکارها و شرایط سخت تایپ به پایان رسد', 'فیلم آزمایشی ۴'),
      ('زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی و جوابگوی سوالات', 'فیلم آزمایشی ۴'),
      ('پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد', 'فیلم آزمایشی ۵'),
      ('لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ', 'فیلم آزمایشی ۵'),
      ('و با استفاده از طراحان گرافیک است چاپگرها و متون بلکه روزنامه', 'فیلم آزمایشی ۵'),
      ('مجله در ستون و سطرآنچنان که لازم است', 'فیلم آزمایشی ۵'),
      ('برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع', 'فیلم آزمایشی ۶'),
      ('هدف بهبود ابزارهای کاربردی می باشد', 'فیلم آزمایشی ۶'),
      ('کتابهای زیادی در شصت و سه درصد گذشته', 'فیلم آزمایشی ۶'),
      ('شناخت فراوان جامعه و متخصصان را می طلبد', 'فیلم آزمایشی ۷'),
      ('تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای', 'فیلم آزمایشی ۷'),
    ];

    return List.generate(texts.length, (i) {
      return QuoteModel(
        id: 'dev_${i + 1}',
        text: texts[i].$1,
        movieTitle: texts[i].$2,
        isBookmarked: false,
      );
    });
  }
}
