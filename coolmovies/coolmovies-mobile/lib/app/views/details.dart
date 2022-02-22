import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final int movie;
  const DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$movie"),
        // leading: WillPopScope(
        //   onWillPop: () async {
        //     Navigator.pop(context, false);
        //     return false;
        //   },
        //   child: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () {
        //       Navigator.pop(context, false);
        //     },
        //   ),
        // ),
      ),
      body: Center(
        child: Container(
          child: Text('details'),
        ),
      ),
    );
  }
}
