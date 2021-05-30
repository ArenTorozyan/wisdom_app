import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/quotes.dart';
import '../provider/quote.dart';
// import 'package:uuid/uuid.dart';

class ModalSheet extends StatefulWidget {
  const ModalSheet({Key key}) : super(key: key);

  @override
  _ModalSheetState createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _authorFocusNode = FocusNode();
  final _commentFocusNode = FocusNode();
  final _typeFocusNode = FocusNode();

  final _authorController = TextEditingController();
  final _quoteController = TextEditingController();
  final _commentController = TextEditingController();
  final _typeController = TextEditingController();

  // var uuid = Uuid();
  var _newQuote = Quote(
    id: null,
    quote: '',
    author: '',
    comment: '',
    type: null,
  );

  @override
  void dispose() {
    _authorFocusNode.dispose();
    _commentFocusNode.dispose();
    _authorController.dispose();
    _quoteController.dispose();
    _commentController.dispose();
    _typeController.dispose();
    _typeFocusNode.dispose();
    super.dispose();
  }

  // ignore: unused_field
  var _isLoading = false;

  void _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) return;
    // _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (!isValid) return;
      _formKey.currentState.save();
      await Provider.of<Quotes>(context, listen: false)
          .addMyQuote(_newQuote.id, _newQuote);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('A quote has been added'),
          duration: Duration(seconds: 2),
          // action: SnackBarAction(
          //   label: 'UNDO',
          //   onPressed: () {
          //     if (this.mounted == true)
          //       Provider.of<Quotes>(context, listen: false).removeMyQuote(id);
          //   },
          // ),
        ),
      );
    } catch (error) {
      print(error);
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('An error occured!'),
          content: Text('Something went wrong.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  // final _quoteTypesList = [
  //   'Motivation',
  //   'Gender',
  //   'Equality',
  // ];

  String _selectedQuoteType;

  Type _quoteType(value) {
    if (value == quoteTypesList[0]) {
      return Type.Motivation;
    }
    if (value == quoteTypesList[1]) {
      return Type.Gender;
    }
    if (value == quoteTypesList[2]) {
      return Type.Equality;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Quote',
                    ),
                    controller: _quoteController,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_authorFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a value!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _newQuote = Quote(
                        quote: value,
                        author: _newQuote.author,
                        id: _newQuote.id,
                        comment: _newQuote.comment,
                        type: _newQuote.type,
                        isFavorite: _newQuote.isFavorite,
                      );
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Author',
                    ),
                    controller: _authorController,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_commentFocusNode);
                    },
                    focusNode: _authorFocusNode,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a value!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _newQuote = Quote(
                        quote: _newQuote.quote,
                        author: value,
                        id: _newQuote.id,
                        comment: _newQuote.comment,
                        type: _newQuote.type,
                        isFavorite: _newQuote.isFavorite,
                      );
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Comment',
                    ),
                    controller: _commentController,
                    focusNode: _commentFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_typeFocusNode);
                    },
                    onSaved: (value) {
                      _newQuote = Quote(
                        quote: _newQuote.quote,
                        author: _newQuote.author,
                        id: _newQuote.id,
                        comment: value,
                        type: _newQuote.type,
                        isFavorite: _newQuote.isFavorite,
                      );
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  DropdownButtonFormField(
                    hint: Text('Choose your quote type'),
                    items: quoteTypesList.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String newValueSelected) {
                      setState(
                        () {
                          this._selectedQuoteType = newValueSelected;
                        },
                      );
                    },
                    value: _selectedQuoteType,
                    onSaved: (value) {
                      _newQuote = Quote(
                        quote: _newQuote.quote,
                        author: _newQuote.author,
                        id: _newQuote.id,
                        comment: _newQuote.comment,
                        type: _quoteType(value),
                        isFavorite: _newQuote.isFavorite,
                      );
                    },
                    focusNode: _typeFocusNode,
                    autovalidateMode: AutovalidateMode.always,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _saveForm();
                          },
                          child: Text(
                            'Add Quote',
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

// showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         content: Text(_quoteController.text),
//       );
//     });

//old _saveQuote method
// void _saveFormS(String quote, String author, String comment) async {
//   final isValid = _formKey.currentState.validate();
//   setState(() {
//     _isLoading = true;
//   });

//   try {
//     if (!isValid) return;
//     await Provider.of<Quotes>(context, listen: false)
//         .addMyQuote(quote, author, comment);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('A quote has been added'),
//         duration: Duration(seconds: 2),
//         // action: SnackBarAction(
//         //   label: 'UNDO',
//         //   onPressed: () {
//         //     if (this.mounted == true)
//         //       Provider.of<Quotes>(context, listen: false).removeMyQuote(id);
//         //   },
//         // ),
//       ),
//     );
//   } catch (error) {
//     await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('An error occured!'),
//         content: Text('Something went wrong.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Okay'),
//           ),
//         ],
//       ),
//     );
//   } finally {
//     setState(() {
//       _isLoading = false;
//     });
//     Navigator.of(context).pop();
//   }
// }

// var _initValues = {
//   'quote': '',
//   'author': '',
//   'comment': '',
//   'type': '',
// };
