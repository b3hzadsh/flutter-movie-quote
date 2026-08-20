import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_quote/injection_container.dart';
import 'package:persian_quote/presentation/theme/app_theme.dart';
import 'package:persian_quote/presentation/cubits/quote_cubit.dart';
import 'package:persian_quote/presentation/cubits/theme_cubit.dart';
import 'package:persian_quote/presentation/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp(sl(), sl()));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final QuoteCubit quoteCubit;

  const MyApp(this.prefs, this.quoteCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: quoteCubit),
        BlocProvider(create: (context) => ThemeCubit(prefs)),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'جملات فیلم‌ها',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            supportedLocales: const [Locale('fa', 'IR')],
            locale: const Locale('fa', 'IR'),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
