import 'package:flutter/material.dart';
import 'package:mac_app/widgets/my_quote_display.dart';
import 'package:provider/provider.dart';

import '../widgets/appBar.dart';
import '../widgets/drawer_main.dart';
import '../widgets/modalWindow.dart';
import '../provider/quotes.dart';

class MyQuotesScreen extends StatefulWidget {
  const MyQuotesScreen({Key key}) : super(key: key);

  static const routeName = '/my_quotes_screen';

  @override
  _MyQuotesScreenState createState() => _MyQuotesScreenState();
}

class _MyQuotesScreenState extends State<MyQuotesScreen> {
  var _isLoading = false;

  Future<void> _refreshMyQuotes(BuildContext context) async {
    await Provider.of<Quotes>(context, listen: false).fetchAndSetMyQuotes();
  }

  @override
  Widget build(BuildContext context) {
    // final quoteData = Provider.of<Quotes>(context);
    final scaffold = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: MyAppBar(
        'My Quotes',
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
                    child: quote.myQuotes.isEmpty
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
                                        'No personal quotes added yet',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: ValueKey(quote.myQuotes[index].id),
                                onDismissed: (direction) async {
                                  try {
                                    await Provider.of<Quotes>(
                                      context,
                                      listen: false,
                                    ).removeMyQuote(quote.myQuotes[index].id);
                                  } catch (error) {
                                    scaffold.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Deleting failed',
                                          // textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Theme.of(context).errorColor,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(
                                    right: 20,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 4,
                                  ),
                                ),
                                confirmDismiss: (direction) {
                                  return showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Are you sure?'),
                                      content: Text(
                                          'Do you want to remove the quote from "My Quotes"?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: Text('Yes'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text('No'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: MyQuoteDisplay(
                                  id: quote.myQuotes[index].id,
                                  quoteItem: quote.myQuotes[index].quote,
                                  author: '-${quote.myQuotes[index].author}',
                                  type: quote.myQuotes[index].type,
                                  isFavorite: quote.myQuotes[index].isFavorite,
                                  marginTop: 40.0,
                                  marginBottom: 1.0,
                                  quoteList: quote.myQuotes,
                                ),
                              );
                            },
                            itemCount: quote.myQuotes.length,
                          )),
              ),
      ),
      floatingActionButton: FloatModalWindow(),
    );
  }
}

// QuoteWidget(
//                       quote.myQuotes[index].quote,
//                       '-${quote.myQuotes[index].author}',
//                       // ),
//                       //   if (quote.myQuotes[index].comment != null)
//                       //     Padding(
//                       //       padding: const EdgeInsets.all(40.0),
//                       //       child: Text(
//                       //         quote.myQuotes[index].comment,
//                       //         style: TextStyle(
//                       //           fontSize: 18,
//                       //           color: Colors.black,
//                       //         ),
//                       //       ),
//                       //     ),
//                       // ],
//                     );
// return Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [

// quote.myQuotes.isNotEmpty
//                 ?: Container(
//                     child: Text(
//                       'No personal quotes added yet',
//                       style: Theme.of(context).textTheme.headline5,
//                     ),
//                   ),

//Just in case need init logic again for spinner

// var _isInit = true;

// @override
// void initState() {
//   //
//   super.initState();
// }

// @override
// void didChangeDependencies() {
//   if (_isInit) {
//     setState(() {
//       _isLoading = true;
//     });
//     Provider.of<Quotes>(context).fetchAndSetMyQuotes().then((_) {
//       setState(() {
//         _isLoading = false;
//       });
//     });
//   }
//   _isInit = false;
//   super.didChangeDependencies();
// }

// var _isInit = true;

// @override
// void initState() {
//   //
//   super.initState();
//   if (_isInit) {
//     setState(() {
//       _isLoading = true;
//     });
//     Provider.of<Quotes>(context, listen: false)
//         .fetchAndSetMyQuotes()
//         .then((_) {
//       setState(() {
//         _isLoading = false;
//       });
//     });
//   }
//   _isInit = false;
// }
