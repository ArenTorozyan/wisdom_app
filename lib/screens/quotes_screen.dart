import 'package:flutter/material.dart';
import 'package:mac_app/widgets/appBar.dart';
import 'package:mac_app/widgets/modalWindow.dart';
// import 'package:mac_app/widgets/settings_button.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer_main.dart';
// import '../widgets/settings_button.dart';
import '../widgets/quote_display.dart';
import '../provider/quotes.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({Key key}) : super(key: key);

  static const routeName = '/quotes_screen';

  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  var _isInit = true;
  // ignore: unused_field
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Quotes>(context).fetchAndSetMyQuotes().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('Collective Wisdom'),
      drawer: DrawerMain(),
      body: QuoteDisplay(),
      floatingActionButton: FloatModalWindow(),
    );
  }
}

// bottomNavigationBar: BottomNavigationBar(
//   // for bottom navigaftiuon you have to manually control the user selectgion and screen output
//   backgroundColor: Theme.of(context).primaryColor,
//   unselectedItemColor: Colors.white,
//   selectedItemColor: Theme.of(context).accentColor,
//   currentIndex: 1,
//   selectedFontSize: 13,
//   unselectedFontSize: 13,
//   type: BottomNavigationBarType.shifting,

//   items: [
//     BottomNavigationBarItem(
//       backgroundColor: Theme.of(context).primaryColor,
//       icon: Icon(Icons.category),
//       title: Text(
//         'Categories',
//         style: TextStyle(fontWeight: FontWeight.bold),
//       ),
//     ),
//     BottomNavigationBarItem(
//       backgroundColor: Theme.of(context).primaryColor,
//       icon: Icon(Icons.star),
//       title: Text(
//         'Favorites',
//         style: TextStyle(fontWeight: FontWeight.bold),
//       ),
//     ),
//   ],
// ),
