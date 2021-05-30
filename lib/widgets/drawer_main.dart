import 'package:flutter/material.dart';
import 'package:mac_app/screens/my_quotes_screen.dart';

import 'package:mac_app/screens/quotes_screen.dart';

class DrawerMain extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Navigation',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Quotes', Icons.format_quote_outlined, () {
            Navigator.of(context).pushReplacementNamed(
              QuotesScreen.routeName,
            );
          }),
          buildListTile('Favortites', Icons.favorite, () {
            Navigator.of(context).pushReplacementNamed('/favorites');
          }),
          buildListTile('My Quotes', Icons.person, () {
            Navigator.of(context).pushNamed(MyQuotesScreen.routeName);
          }),
          buildListTile('Settings', Icons.settings, () {
            Navigator.of(context).pushNamed('/settings');
          }),
          SizedBox(
            height: 400,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildListTile('Log Out', Icons.logout, () {
                Navigator.of(context).pushNamed('/');
              }),
            ],
          )
        ],
      ),
    );
  }
}
