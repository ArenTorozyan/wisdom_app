import 'package:flutter/material.dart';
import 'package:mac_app/provider/dark_theme.dart';
import 'package:mac_app/screens/edit_quote_screen.dart';
import 'package:mac_app/screens/login_screen.dart';
import 'package:mac_app/screens/my_quotes_screen.dart';
import 'package:provider/provider.dart';

import './screens/quotes_screen.dart';
import './screens/settings_screen.dart';
import './screens/favorites_screen.dart';
import './models/styles.dart';

import './provider/quotes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Quotes(),
        ),
        ChangeNotifierProvider(
          create: (_) => themeChangeProvider,
        )
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, child) => MaterialApp(
          title: 'Quotes',
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(
            themeChangeProvider.darkTheme,
            context,
          ),
          home: LoginScreen(),
          routes: {
            QuotesScreen.routeName: (_) => QuotesScreen(),
            SettingScreen.routeName: (_) => SettingScreen(),
            FavoritesScreen.routeName: (_) => FavoritesScreen(),
            MyQuotesScreen.routeName: (_) => MyQuotesScreen(),
            EditQuoteScreen.routeName: (_) => EditQuoteScreen(),
          },
        ),
      ),
    );
  }
}

// darkTheme: ThemeData.dark(),
// theme: ThemeData(
//   primarySwatch: Colors.red,
//   // accentColor: Colors.green,
//   canvasColor: Colors.blue[400],
//   fontFamily: 'Raleway',
//   textTheme: TextTheme(
//     headline6: TextStyle(
//       fontSize: 28,
//       color: Colors.black,
//       fontFamily: 'RobotoCondensed',
//       fontWeight: FontWeight.bold,
//     ),
//     headline5: TextStyle(
//       fontSize: 20,
//       color: Colors.white,
//       fontFamily: 'RobotoCondensed',
//       fontWeight: FontWeight.w500,
//     ),
//   ),
// ),
