import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key key}) : super(key: key);

  static const routeName = '/settings';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Widget _buildSwitchListTile(
    String title,
    String description,
    bool value,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(
        title,
      ),
      value: value,
      subtitle: Text(
        description,
        // style: TextStyle(color: Colors.white),
      ),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your preferences',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // _buildSwitchListTile(
                //   'Gender Quotes',
                //   'Only gender problem related quotes',
                //   true,
                //   () {
                //     print('hello');
                //   },
                // ),
                Consumer<DarkThemeProvider>(
                  builder: (context, value, child) => _buildSwitchListTile(
                    'Dark Mode',
                    'Saves your eyes',
                    themeChange.darkTheme,
                    (bool value) {
                      themeChange.darkTheme = value;
                    },
                  ),
                ),
                // _buildSwitchListTile(
                //   'Allow push-notifications',
                //   'Improves user experience',
                //   true,
                //   () {
                //     print('hello');
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
