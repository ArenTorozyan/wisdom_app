import 'package:flutter/material.dart';
import 'package:mac_app/provider/quotes.dart';
import 'package:mac_app/widgets/quote_widget.dart';
import 'package:provider/provider.dart';

import 'actionButton.dart';

import '../provider/quote.dart';
import '../provider/quotes.dart';

class QuoteDisplay extends StatelessWidget {
  const QuoteDisplay({Key key}) : super(key: key);

  Widget quoteType(type) {
    switch (type) {
      case Type.Motivation:
        return Icon(Icons.star_border);
        break;
      case Type.Gender:
        return Icon(Icons.gesture);
        break;
      case Type.Equality:
        return Icon(Icons.stop_circle_outlined);
        break;
      default:
        return Icon(Icons.umbrella);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<Quotes>(
            builder: (context, quote, child) => Container(
              margin: EdgeInsets.only(
                bottom: 250,
                top: 110,
              ),
              child: GestureDetector(
                // ignore: non_constant_identifier_names
                onHorizontalDragEnd: (DragEndDetails) => quote.nextQuote(),
                // onHorizontalDragStart: (DragEndDetails) =>
                //     quote.previousQuote(),
                // onTap: quote.nextQuote,
                child: Column(
                  children: [
                    QuoteWidget(
                      quote.quotes[quote.index].quote,
                      '-${quote.quotes[quote.index].author}',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: quoteType(
                            quote.quotes[quote.index].type,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            quote.quotes[quote.index].isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          onPressed: () {}, //quote.toggleFavoriteStatus(
                          //quote.quotes, quote.quotes[quote.index].id),
                          color: Theme.of(context).buttonColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Consumer<Quotes>(
            builder: (context, quote, child) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: ActionButton(
                      quote.previousQuote,
                      'Prev',
                      Theme.of(context).canvasColor,
                      Colors.white,
                    ),
                  ),
                  ActionButton(
                    quote.nextQuote,
                    'Next',
                    Theme.of(context).primaryColor,
                    Colors.white,
                  ),
                  // GestureDetector(
                  //   // onHorizontalDragEnd: quote.previousQuote,
                  //   onTap: quote.nextQuote,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Center(
//             // child: ConstrainedBox(
//             //   constraints: BoxConstraints(
//             //     minWidth: 100,
//             //     minHeight: 380,
//             //     maxWidth: 350,
//             //     maxHeight: 800,
//             //   ),
//             // child: Consumer<Quote>(
//             //   child: Column(
//             //     children: [
//             child:

// quote.quotes[quote.index].type == Type.Motivation
//                               ? Icons.pregnant_woman
//                               : Icons.star,
// IconButton(
//                         icon: Icon(
//                           switch (quote.quotes[quote.index].type) {
//       case Type.Motivation:
//         Icons.pregnant_woman;
//         break;
//       case Type.Gender:
//         return '🙋‍♀️';
//         break;
//       case Type.Equality:
//         return '👨‍👨‍👦';
//         break;
//       default:
//         return 'Unknown';
//     }
//  ),
//                         onPressed: () {},
//                       ),

// final quoteId = ModalRoute.of(context).settings.arguments as String;
// final activeQuote = Provider.of<Quotes>(
//   context,
//   listen: false,
// ).findById(quoteId);
// final quoteModel = Provider.of<Quote>(
//   context,
//   listen: false,
// );

//  Consumer<Quotes>(
//             builder: (context, quote, child) => GradientButton(
//               null,
//               'Random Quote',
//               Colors.blue,
//               Colors.red,
//               Colors.white,
//             ),
//           ),
