import 'package:flutter/material.dart';

class QuoteWidget extends StatelessWidget {
  final String quote;
  final String author;

  const QuoteWidget(
    this.quote,
    this.author,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 1,
      ),
      child: Column(
        children: [
          Text(
            quote,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.white,
            ),
          ),
          Text(
            author,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
