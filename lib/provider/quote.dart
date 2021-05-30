import 'package:flutter/foundation.dart';
import 'package:enum_to_string/enum_to_string.dart';

enum Type {
  Motivation,
  Gender,
  Equality,
}

//to transform JSON string to enum TYPE (fetching data from database)
convertJSONtoEnum(String value) {
  return EnumToString.fromString(Type.values, value);
}

convertEnumtoJSON(Type value) {
  return EnumToString.convertToString(value);
}

final quoteTypesList = [
  'Motivation',
  'Gender',
  'Equality',
];

class Quote with ChangeNotifier {
  final String id;
  final String quote;
  final String author;
  final Type type;
  final String comment;
  bool isFavorite;

  Quote({
    @required this.id,
    @required this.quote,
    @required this.author,
    this.type,
    this.comment,
    this.isFavorite = false,
  });
}

// String placeholderTest =
//     'In three words I can sum up everything I\'ve learned about life: it goes on.';

// //test provider function
// void changeQuote() {
//   placeholderTest = 'Quote has Changed!';
//   notifyListeners();
// }

// Type get getQuoteTypes{
//   var motivation = Type.Motivation;
//   var gender = Type.Gender;
//   var equality = Type.Equality;

// };
