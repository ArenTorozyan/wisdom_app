import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final Function _action;
  final String _buttonText;
  final Color _backgroundColor;
  final Color _foregroundColor;

  ActionButton(this._action, this._buttonText, this._backgroundColor,
      this._foregroundColor);

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(widget._buttonText),
      onPressed: widget._action,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(widget._backgroundColor),
        foregroundColor: MaterialStateProperty.all(widget._foregroundColor),
      ),
    );
  }
}
