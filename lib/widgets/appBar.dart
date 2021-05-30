import 'package:flutter/material.dart';

import '../widgets/settings_button.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  MyAppBar(this.text);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text,
      ),
      iconTheme: IconThemeData(color: Colors.white),
      actions: [
        SettingsButton(),
      ],
    );
  }

  @override
  // ignore: todo
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
