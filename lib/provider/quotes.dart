import 'quote.dart';
import '../models/http_extention.dart';

// import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Quotes extends Quote {
  List<Quote> _quotes = [
    Quote(
      id: 'q1',
      quote:
          'In three words I can sum up everything I\'ve learned about life: it goes on.',
      author: 'Robert Frost',
      type: Type.Motivation,
      comment: '',
    ),
    Quote(
      id: 'q2',
      quote:
          'Live as if you were to die tomorrow. Learn as if you were to live forever.',
      author: 'Mahatma Gandhi',
      type: Type.Gender,
      comment: '',
    ),
    Quote(
      id: 'q2',
      quote: 'Always forgive your enemies; nothing annoys them so much.',
      author: 'Oscar Wilde',
      type: Type.Gender,
      comment: '',
    ),
    Quote(
      id: 'q3',
      quote: 'If you tell the truth, you don\'t have to remember anything.',
      author: 'Mark Twain',
      type: Type.Equality,
      comment: '',
    ),
    Quote(
      id: 'q4',
      quote: 'You only live once, but if you do it right, once is enough.',
      author: 'Mae West',
      type: Type.Equality,
      comment: '',
    ),
    Quote(
      id: 'q5',
      quote: 'A friend is someone who knows all about you and still loves you.',
      author: 'Elbert Hubbard',
      type: Type.Equality,
      comment: '',
    ),
    Quote(
      id: 'q6',
      quote:
          'It is our choices, Harry, that show what we truly are, far more than our abilities.',
      author: 'J.K. Rowling',
      type: Type.Equality,
      comment: '',
    ),
    Quote(
      id: 'q7',
      quote:
          'The fool doth think he is wise, but the wise man knows himself to be a fool.',
      author: 'William Shakespeare',
      type: Type.Equality,
      comment: '',
    ),
    Quote(
      id: 'q8',
      quote: 'The truth will set you free, but first it will piss you off.',
      author: 'Joe Klaas',
      type: Type.Equality,
      comment: '',
    ),
    Quote(
      id: 'q9',
      quote: 'Life is what happens to us while we are making other plans.',
      author: 'Allen Saunders',
      type: Type.Equality,
      comment: '',
    ),
    Quote(
      id: 'q10',
      quote:
          'I have not failed. I\'ve just found 10,000 ways that won\'t work.',
      author: 'Thomas A. Edison',
      type: Type.Equality,
      comment: '',
    ),
    Quote(
      id: 'q11',
      quote:
          'I like nonsense, it wakes up the brain cells. Fantasy is a necessary ingredient in living.',
      author: 'Dr. Seuss',
      type: Type.Equality,
      comment: '',
    ),
    Quote(
      id: 'q12',
      quote: 'Love all, trust a few, do wrong to none.',
      author: 'William Shakespeare, All\'s Well That Ends Well',
      type: Type.Equality,
      comment: '',
    ),
  ];

  List<Quote> get quotes {
    return [..._quotes];
  }

  List<Quote> _favoriteQuotes = [];

  List<Quote> get favoriteQuotes {
    return [..._favoriteQuotes];
  }

  List<Quote> _myQuotes = [];

  List<Quote> get myQuotes {
    return [..._myQuotes];
  }

  Future<void> fetchAndSetMyQuotes() async {
    final url = Uri.parse(
      'https://collective-wisdom-32b34-default-rtdb.asia-southeast1.firebasedatabase.app/my-quotes.json',
    );

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) return;
      final List<Quote> myLoadedQuotes = [];
      extractedData.forEach(
        (quoteId, quoteData) {
          myLoadedQuotes.add(
            Quote(
              id: quoteId,
              quote: quoteData['quote'],
              author: quoteData['author'],
              type: convertJSONtoEnum(quoteData['type']),
              comment: quoteData['comment'],
              isFavorite: quoteData['isFavorite'],
            ),
          );
          _myQuotes = myLoadedQuotes;
          notifyListeners();
        },
      );
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchAndSetFavoriteQuotes() async {
    final url = Uri.parse(
      'https://collective-wisdom-32b34-default-rtdb.asia-southeast1.firebasedatabase.app/my-quotes.json',
    );
    // final urlQuotes = Uri.parse(
    //   'https://collective-wisdom-32b34-default-rtdb.asia-southeast1.firebasedatabase.app/quotes.json',
    // );

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // final responseQuotes = await http.get(urlQuotes);
      // final extractedDataQuotes =
      //     json.decode(responseQuotes.body) as Map<String, dynamic>;
      if (extractedData == null) return;
      final List<Quote> myLoadedQuotes = [];
      extractedData.forEach(
        (quoteId, quoteData) {
          if (quoteData['isFavorite']) {
            myLoadedQuotes.add(
              Quote(
                id: quoteId,
                quote: quoteData['quote'],
                author: quoteData['author'],
                type: convertJSONtoEnum(quoteData['type']),
                comment: quoteData['comment'],
                isFavorite: quoteData['isFavorite'],
              ),
            );
          }
          _favoriteQuotes = myLoadedQuotes;
          notifyListeners();
        },
      );
      // if (extractedDataQuotes != null)
      //   extractedDataQuotes.forEach(
      //     (quoteId, quoteData) {
      //       if (quoteData['isFavorite']) {
      //         myLoadedQuotes.add(
      //           Quote(
      //             id: quoteId,
      //             quote: quoteData['quote'],
      //             author: quoteData['author'],
      //             type: convertJSONtoEnum(quoteData['type']),
      //             comment: quoteData['comment'],
      //             isFavorite: quoteData['isFavorite'],
      //           ),
      //         );
      //       }
      //       _favoriteQuotes.addAll(myLoadedQuotes);
      //       notifyListeners();
      //     },
      //   );
    } catch (error) {
      throw (error);
    }
  }

  //add quotes to List<Quote> myQuotes
  Future<void> addMyQuote(String quoteId, Quote newQuote) async {
    final url = Uri.parse(
      'https://collective-wisdom-32b34-default-rtdb.asia-southeast1.firebasedatabase.app/my-quotes.json',
    );
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'quote': newQuote.quote,
            'author': newQuote.author,
            'comment': newQuote.comment,
            'type': convertEnumtoJSON(newQuote.type),
            'isFavorite': newQuote.isFavorite,
          },
        ),
      );
      final myNewQuote = Quote(
        id: json.decode(response.body)['name'],
        quote: newQuote.quote,
        author: newQuote.author,
        type: newQuote.type,
        comment: newQuote.comment,
        isFavorite: newQuote.isFavorite,
      );
      _myQuotes.add(myNewQuote);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateMyQuote(String quoteId, Quote newQuote) async {
    final quoteIndex = _myQuotes.indexWhere((quote) => quote.id == quoteId);
    final quoteIdexFav =
        _favoriteQuotes.indexWhere((quote) => quote.id == quoteId);
    if (quoteIndex >= 0) {
      final url = Uri.parse(
        'https://collective-wisdom-32b34-default-rtdb.asia-southeast1.firebasedatabase.app/my-quotes/$quoteId.json',
      );
      try {
        final response = await http.patch(
          url,
          body: json.encode(
            {
              'quote': newQuote.quote,
              'author': newQuote.author,
              'comment': newQuote.comment,
              'type': convertEnumtoJSON(newQuote.type),
              'isFavorite': newQuote.isFavorite,
            },
          ),
        );

        if (response.statusCode == 200) {
          _myQuotes[quoteIndex] = newQuote;
          if (quoteIdexFav >= 0) _favoriteQuotes[quoteIdexFav] = newQuote;
        } else {
          throw Error();
        }
      } catch (error) {
        throw error;
      }
      notifyListeners();
    }
  }

  Future<void> removeMyQuote(String quoteId) async {
    final url = Uri.parse(
      'https://collective-wisdom-32b34-default-rtdb.asia-southeast1.firebasedatabase.app/my-quotes/$quoteId.json',
    );

    final myQuoteIdex = _myQuotes.indexWhere((quote) => quote.id == quoteId);
    var myExistingQuote = _myQuotes[myQuoteIdex];
    // _myQuotes.removeWhere((quote) => quote.id == quoteId);
    _myQuotes.removeAt(myQuoteIdex);
    //ADD REMOVE FROM FAVORITES FUNCTIONALITY once adjusted the structure to accept isFavorite property to database

    var quoteIdexFav =
        _favoriteQuotes.indexWhere((quote) => quote.id == quoteId);
    var favExistingQuote;
    quoteIdexFav != null
        ? favExistingQuote = _favoriteQuotes[quoteIdexFav]
        : favExistingQuote = null;

    _favoriteQuotes.removeAt(quoteIdexFav);

    notifyListeners();

    final response = await http.delete(url);
    print(response.statusCode);
    if (response.statusCode != 200) {
      _favoriteQuotes.insert(quoteIdexFav, favExistingQuote);
      _myQuotes.insert(myQuoteIdex, myExistingQuote);
      notifyListeners();
      throw HttpException('Could not delete a quote');
    }
    myExistingQuote = null;
    favExistingQuote = null;
  }

  //needs a fix in order to use it with method - toggleFavoriteStatus()!
  //important to use in order to follow Don't repeat yourselt principle!
  Quote findById(String quoteId) {
    return _myQuotes.firstWhere((quote) => quote.id == quoteId);
  }

  Quote _findById(List quoteList, String quoteId) {
    return quoteList.firstWhere((quote) => quote.id == quoteId);
  }

  //functionality for displaying favorite quote (myQuotes and quotes) on favoriteQuotesScreen

  Future<void> toggleFavoriteStatus(List quoteList, String quoteId) async {
    if (!_findById(quoteList, quoteId).isFavorite) {
      _findById(quoteList, quoteId).isFavorite = true;
      _favoriteQuotes.add(
        _findById(quoteList, quoteId),
      );
      notifyListeners();

      final url = Uri.parse(
        'https://collective-wisdom-32b34-default-rtdb.asia-southeast1.firebasedatabase.app/my-quotes/$quoteId.json',
      );
      final response = await http.patch(
        url,
        body: json.encode(
          {
            'quote': _findById(quoteList, quoteId).quote,
            'author': _findById(quoteList, quoteId).author,
            'comment': _findById(quoteList, quoteId).comment,
            'type': convertEnumtoJSON(_findById(quoteList, quoteId).type),
            'isFavorite': _findById(quoteList, quoteId).isFavorite,
          },
        ),
      );
      if (response.statusCode != 200) {
        _findById(quoteList, quoteId).isFavorite = false;
        _favoriteQuotes.remove(
          _findById(quoteList, quoteId),
        );
        notifyListeners();
        throw HttpException('Could not add to favorites');
      }
      //if myQuote is added to favorites, then remove from favorites
    } else {
      _findById(quoteList, quoteId).isFavorite = false;
      _favoriteQuotes.remove(
        _findById(quoteList, quoteId),
      );
      notifyListeners();
      final url = Uri.parse(
        'https://collective-wisdom-32b34-default-rtdb.asia-southeast1.firebasedatabase.app/my-quotes/$quoteId.json',
      );
      final response = await http.patch(
        url,
        body: json.encode(
          {
            'isFavorite': _findById(quoteList, quoteId).isFavorite,
          },
        ),
      );
      if (response.statusCode != 200) {
        _findById(quoteList, quoteId).isFavorite = true;
        _favoriteQuotes.add(
          _findById(quoteList, quoteId),
        );
        notifyListeners();
        throw HttpException('Could not add to favorites');
      }
    }
  }

//functionality for changing quotes on quotes_screen
  var index = 0;

  void nextQuote() {
    index < _quotes.length - 1 ? index++ : index = 0;

    notifyListeners();
  }

  void previousQuote() {
    index != 0 ? index-- : index = (_quotes.length - 1);
    notifyListeners();
  }
}

// List<Quote> get favoriteQuotes {
//   return _quotes.where((element) => element.isFavorite).toList();
// // }

// Quote findById(String id) {
//   return _quotes.firstWhere((quote) => quote.id == id);
// }

// String get quoteType {
//   switch (type) {
//     case Type.Motivation:
//       return '📢';
//       break;
//     case Type.Gender:
//       return '🙋‍♀️';
//       break;
//     case Type.Equality:
//       return '👨‍👨‍👦';
//       break;
//     default:
//       return 'Unknown';
//   }
// }

// Type _quoteType(value) {
//   if (value == quoteTypesList[0]) {
//     return Type.Motivation;
//   }
//   if (value == quoteTypesList[1]) {
//     return Type.Gender;
//   }
//   if (value == quoteTypesList[2]) {
//     return Type.Equality;
//   }
//   return null;
// }
// var uuid = Uuid();

// final url = Uri.parse(
//   'https://collective-wisdom-32b34-default-rtdb.asia-southeast1.firebasedatabase.app/my-quotes/$quoteId.json',
// );
// await http.patch(
//   url,
//   body: json.encode(
//     {
//       'quote': newQuote.quote,
//       'author': newQuote.author,
//       'comment': newQuote.comment,
//       'type':
//     },
//   ),
// );
// if (quoteIdexFav >= 0) {
//       favoriteQuotes[quoteIdexFav] = newQuote;
//     }
//     notifyListeners();
// print(response.statusCode);

// void toggleFavoriteStatus(List quoteList, String quoteId) {
//     // isFavorite = !isFavorite;
//     if (!quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite) {
//       quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite = true;
//       favoriteQuotes.add(
//         quoteList.firstWhere((quote) => quote.id == quoteId),
//       );
//     } else {
//       quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite = false;
//       favoriteQuotes.remove(
//         quoteList.firstWhere((quote) => quote.id == quoteId),
//       );
//     }

//     notifyListeners();
//   }

// void toggleFavoriteStatusMyQuotes(List quoteList, String quoteId) {
//     if (!quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite) {
//       quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite = true;
//       favoriteQuotes.add(
//         quoteList.firstWhere((quote) => quote.id == quoteId),
//       );
//     } else {
//       quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite = false;
//       favoriteQuotes.remove(
//         quoteList.firstWhere((quote) => quote.id == quoteId),
//       );
//     }

//     notifyListeners();
//   }

//fix. really weird behaviour. Adds a lot of quotes at once in QUOTES. Does not want to add quotes from MYQUOTES because of first condition
//checks if quoteList has the same element as _quotes
// if (quoteList.firstWhere((quote) => quote.id == quoteId) ==
//     _quotes.firstWhere((quote) => quote.id == quoteId)) {
//   //checks if quote not added to favorites, then add to favorites and
//   if (!quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite) {
//     quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite = true;
//     _favoriteQuotes.add(
//       quoteList.firstWhere((quote) => quote.id == quoteId),
//     );
//     final url = Uri.parse(
//       'https://collective-wisdom-32b34-default-rtdb.asia-southeast1.firebasedatabase.app/quotes/$quoteId.json',
//     );
//     final response = await http.post(
//       url,
//       body: json.encode(
//         {
//           'quote':
//               quoteList.firstWhere((quote) => quote.id == quoteId).quote,
//           'author':
//               quoteList.firstWhere((quote) => quote.id == quoteId).author,
//           'comment':
//               quoteList.firstWhere((quote) => quote.id == quoteId).comment,
//           'type': convertEnumtoJSON(
//               quoteList.firstWhere((quote) => quote.id == quoteId).type),
//           'isFavorite': quoteList
//               .firstWhere((quote) => quote.id == quoteId)
//               .isFavorite,
//         },
//       ),
//     );
//     if (response.statusCode != 200) {
//       quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite =
//           false;
//       _favoriteQuotes.remove(
//         quoteList.firstWhere((quote) => quote.id == quoteId),
//       );
//       notifyListeners();
//       throw HttpException('Could not add to favorites');
//     }
//     //if quote is added to favorites, then remove from favorites
//   } else {
//     quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite = false;
//     _favoriteQuotes.remove(
//       quoteList.firstWhere((quote) => quote.id == quoteId),
//     );
//     final url = Uri.parse(
//       'https://collective-wisdom-32b34-default-rtdb.asia-southeast1.firebasedatabase.app/quotes/$quoteId.json',
//     );
//     final response = await http.patch(
//       url,
//       body: json.encode(
//         {
//           'isFavorite': quoteList
//               .firstWhere((quote) => quote.id == quoteId)
//               .isFavorite,
//         },
//       ),
//     );
//     if (response.statusCode != 200) {
//       quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite =
//           true;
//       _favoriteQuotes.add(
//         quoteList.firstWhere((quote) => quote.id == quoteId),
//       );
//       notifyListeners();
//       throw HttpException('Could not add to favorites');
//     }
//   }
//   notifyListeners();
//   //if quote does not belong to @quotes@
// // } else {
// //checks if myQuote not added to favorites, then add to favorites and
//  Future<void> toggleFavoriteStatusQuotes(
//       List quoteList, String quoteId) async {
//     if (!quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite) {
//       quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite = true;
//       _favoriteQuotes.add(
//         quoteList.firstWhere((quote) => quote.id == quoteId),
//       );
//       final url = Uri.parse(
//         'https://collective-wisdom-32b34-default-rtdb.asia-southeast1.firebasedatabase.app/quotes/$quoteId.json',
//       );
//       final response = await http.post(
//         url,
//         body: json.encode(
//           {
//             'quote': quoteList.firstWhere((quote) => quote.id == quoteId).quote,
//             'author':
//                 quoteList.firstWhere((quote) => quote.id == quoteId).author,
//             'comment':
//                 quoteList.firstWhere((quote) => quote.id == quoteId).comment,
//             'type': convertEnumtoJSON(
//                 quoteList.firstWhere((quote) => quote.id == quoteId).type),
//             'isFavorite':
//                 quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite,
//           },
//         ),
//       );
//       if (response.statusCode != 200) {
//         quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite = false;
//         _favoriteQuotes.remove(
//           quoteList.firstWhere((quote) => quote.id == quoteId),
//         );
//         notifyListeners();
//         throw HttpException('Could not add to favorites');
//       }
//       //if quote is added to favorites, then remove from favorites
//     } else {
//       quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite = false;
//       _favoriteQuotes.remove(
//         quoteList.firstWhere((quote) => quote.id == quoteId),
//       );
//       final url = Uri.parse(
//         'https://collective-wisdom-32b34-default-rtdb.asia-southeast1.firebasedatabase.app/quotes/$quoteId.json',
//       );
//       final response = await http.patch(
//         url,
//         body: json.encode(
//           {
//             'isFavorite':
//                 quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite,
//           },
//         ),
//       );
//       if (response.statusCode != 200) {
//         quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite = true;
//         _favoriteQuotes.add(
//           quoteList.firstWhere((quote) => quote.id == quoteId),
//         );
//         notifyListeners();
//         throw HttpException('Could not add to favorites');
//       }
//     }
//     notifyListeners();
//   }

// checks if quoteList has the same element as _quotes
// if (quoteList.firstWhere((quote) => quote.id == quoteId) ==
//     _quotes.firstWhere((quote) => quote.id == quoteId)) {
//   if (!quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite) {
//     quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite = true;
//     _favoriteQuotes.add(
//       quoteList.firstWhere((quote) => quote.id == quoteId),
//     );
//     notifyListeners();
//   }
//   if (quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite) {
//     quoteList.firstWhere((quote) => quote.id == quoteId).isFavorite = false;
//     _favoriteQuotes.remove(
//       quoteList.firstWhere((quote) => quote.id == quoteId),
//     );
//     notifyListeners();
//   }
// } else {

//works with bugs for QUOTES because when undo the favoritebutton -> enters scenario for myQuotes //needs a fix
