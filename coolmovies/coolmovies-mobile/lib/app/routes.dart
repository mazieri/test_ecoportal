import 'package:flutter/material.dart';

import 'package:coolmovies/export_pages.dart';

class RoutesGenerate {
  static Route<dynamic> onGenerateRoute(settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case "/details":
        return MaterialPageRoute(
          builder: (_) => DetailsPage(
            i: settings.arguments,
          ),
        );
      default:
        return _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: const Text("ROUTE ERROR"),
          ),
          body: const Center(
            child: Text(
              "ROUTE ERROR",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 60,
              ),
            ),
          ),
        );
      },
    );
  }
}
