import 'package:flutter/material.dart';

class TextOutput extends StatelessWidget {
  final String sentence;

  TextOutput(this.sentence);

  @override
  Widget build(BuildContext context) {
    return Text(
      sentence,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 28,
        color: Colors.white,
      ),
    );
  }
}
