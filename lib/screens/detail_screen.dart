
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String text;

  const DetailScreen({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Synonym"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
    );
  }
}