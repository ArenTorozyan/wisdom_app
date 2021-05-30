import 'package:flutter/material.dart';
import 'package:mac_app/widgets/my_quote_display.dart';
// import 'package:mac_app/widgets/quote_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer_main.dart';
import '../widgets/appBar.dart';

import '../provider/quotes.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  static const routeName = '/favorites';

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  var _isLoading = false;

  Future<void> _refreshMyQuotes(BuildContext context) async {
    await Provider.of<Quotes>(context, listen: false)
        .fetchAndSetFavoriteQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        'Favorites',
      ),
      drawer: DrawerMain(),
      body: RefreshIndicator(
        onRefresh: () => _refreshMyQuotes(context),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Quotes>(
                builder: (context, quote, child) => Center(
                  child: quote.favoriteQuotes.isEmpty
                      ? ListView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 300,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'No favorites added yet',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return MyQuoteDisplay(
                                id: quote.favoriteQuotes[index].id,
                                quoteItem: quote.favoriteQuotes[index].quote,
                                author: quote.favoriteQuotes[index].author,
                                type: quote.favoriteQuotes[index].type,
                                isFavorite:
                                    quote.favoriteQuotes[index].isFavorite,
                                marginBottom: 40,
                                marginTop: 10,
                                quoteList: quote.favoriteQuotes);
                          },
                          itemCount: quote.favoriteQuotes.length,
                        ),
                ),
              ),
      ),
    );
  }
}

// var _isInit = true;

// @override
// void initState() {
//   if (_isInit) {
//     setState(() {
//       _isLoading = true;
//     });
//     Provider.of<Quotes>(context, listen: false)
//         .fetchAndSetFavoriteQuotes()
//         .then((_) {
//       setState(() {
//         _isLoading = false;
//       });
//     });
//   }
//   _isInit = false;
//   super.initState();
// }

// quote.findById(quote.favoriteQuotes[index].id) != null
//     ? quote.quotes
//     : quote.myQuotes,

// return QuoteWidget(
//   quote.favoriteQuotes[index].quote,
//   '-${quote.favoriteQuotes[index].author}',
// );
