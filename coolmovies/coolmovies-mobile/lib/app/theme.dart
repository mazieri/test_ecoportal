import 'package:flutter/material.dart';

import 'package:coolmovies/app/routes.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cool Movies App',
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          // primaryVariant: primaryVariant,
          // secondary: Colors.white,
          // secondaryVariant: secondaryVariant,
          // surface: Colors.black,
          // background: Colors.black,
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
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: "/",
      onGenerateRoute: RoutesGenerate.onGenerateRoute,
    );
  }
}
