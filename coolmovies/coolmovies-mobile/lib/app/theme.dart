import 'package:flutter/material.dart';

import 'package:coolmovies/export_pages.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cool Movies App',
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.green,
          // primaryVariant: primaryVariant,
          secondary: Colors.green,
          // secondaryVariant: secondaryVariant,
          // surface: surface,
          // background: background,
          // error: error,
          // onPrimary: onPrimary,
          // onSecondary: onSecondary,
          // onSurface: onSurface,
          // onBackground: onBackground,
          // onError: onError,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/details': (context) => const DetailsPage(movie: 1),
      },
    );
  }
}
