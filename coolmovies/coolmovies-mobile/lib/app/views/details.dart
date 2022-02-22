import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final int movie;
  const DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(movie.toString()),
        ),
      ),
    );
  }
}
