import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.settings,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(
          '/settings',
        );
      },
    );
  }
}
