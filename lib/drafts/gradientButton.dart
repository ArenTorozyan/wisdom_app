import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  final Function _randomQuote;
  final String _buttonText;
  final Color _gradientStart;
  final Color _gradientEnd;
  final Color _colorText;

  GradientButton(this._randomQuote, this._buttonText, this._gradientStart,
      this._gradientEnd, this._colorText);

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 40,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [widget._gradientStart, widget._gradientEnd],
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
        ),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: TextButton(
        child: new Text(widget._buttonText),
        onPressed: widget._randomQuote,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(widget._colorText),
        ),
      ),
    );
  }
}

// ElevatedButton(
//   child: Text('Random Quote'),
//   onPressed: () {
//     setState(
//       () {
//         _setIndexRandom();
//         _sentence = _sentences[_sentenceIndex];
//       },
//     );
//   },
//   style: ButtonStyle(
//     backgroundColor: MaterialStateProperty.all(Colors.red),
//     foregroundColor: MaterialStateProperty.all(Colors.white),
//   ),
// ),
