import 'package:flutter/material.dart';
import 'package:mac_app/screens/edit_quote_screen.dart';
import 'package:provider/provider.dart';

import '../provider/quotes.dart';
import '../provider/quote.dart';
import 'quote_widget.dart';

class MyQuoteDisplay extends StatelessWidget {
  final String id;
  final String quoteItem;
  final String author;
  final Type type;
  final bool isFavorite;
  final double marginTop;
  final double marginBottom;
  final List quoteList;

  const MyQuoteDisplay({
    this.id,
    this.quoteItem,
    this.author,
    this.type,
    this.isFavorite,
    this.marginTop,
    this.marginBottom,
    this.quoteList,
  });

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
    return Consumer<Quotes>(
      builder: (context, quote, child) => Container(
        margin: EdgeInsets.only(
          bottom: marginBottom,
          top: marginTop,
        ),
        child: Column(
          children: [
            QuoteWidget(
              quoteItem,
              author,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: quoteType(
                    type,
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
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: () => quote.toggleFavoriteStatus(quoteList, id),
                  color: Theme.of(context).buttonColor,
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      EditQuoteScreen.routeName,
                      arguments: id,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
