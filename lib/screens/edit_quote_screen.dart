import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../widgets/drawer_main.dart';
import '../widgets/appBar.dart';
import '../provider/quotes.dart';
import '../provider/quote.dart';

class EditQuoteScreen extends StatefulWidget {
  EditQuoteScreen({Key key}) : super(key: key);
  static const routeName = '/edit-quote';

  @override
  _EditQuoteScreenState createState() => _EditQuoteScreenState();
}

class _EditQuoteScreenState extends State<EditQuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  // final _quoteFocusNode = FocusNode();
  final _authorFocusNode = FocusNode();
  final _commentFocusNode = FocusNode();
  final _typeFocusNode = FocusNode();

  var _editedQuote = Quote(
    id: null,
    quote: '',
    author: '',
    comment: '',
  );

  var _initValues = {
    'quote': '',
    'author': '',
    'comment': '',
    'type': '',
  };

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final quoteId = ModalRoute.of(context).settings.arguments as String;
      if (quoteId != null) {
        _editedQuote = Provider.of<Quotes>(
          context,
          listen: false,
        ).findById(quoteId);
        _initValues = {
          'quote': _editedQuote.quote,
          'author': _editedQuote.author,
          'comment': _editedQuote.comment,
          'type': convertEnumtoJSON(_editedQuote.type),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // _quoteFocusNode.dispose();
    _authorFocusNode.dispose();
    _commentFocusNode.dispose();
    _typeFocusNode.dispose();
    super.dispose();
  }

  var _isLoading = false;

  Future<void> _updateForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Quotes>(context, listen: false).updateMyQuote(
        _editedQuote.id,
        _editedQuote,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Changes have been applied'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
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
        Navigator.of(context).pop();
      });
    }
  }

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
    return Scaffold(
      appBar: MyAppBar(
        'Edit Quote',
      ),
      // drawer: DrawerMain(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Theme.of(context).canvasColor,
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Quote',
                        // labelStyle: TextStyle(
                        //     color: _quoteFocusNode.hasFocus
                        //         ? Colors.red
                        //         : Theme.of(context).buttonColor),
                      ),
                      // controller: _quoteController,
                      initialValue: _initValues['quote'],
                      maxLines: 3,
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
                        _editedQuote = Quote(
                          quote: value,
                          author: _editedQuote.author,
                          id: _editedQuote.id,
                          comment: _editedQuote.comment,
                          isFavorite: _editedQuote.isFavorite,
                          type: _editedQuote.type,
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
                      // controller: _authorController,
                      initialValue: _initValues['author'],
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
                        _editedQuote = Quote(
                          quote: _editedQuote.quote,
                          author: value,
                          id: _editedQuote.id,
                          comment: _editedQuote.comment,
                          isFavorite: _editedQuote.isFavorite,
                          type: _editedQuote.type,
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
                      // controller: _commentController,
                      initialValue: _initValues['comment'],
                      focusNode: _commentFocusNode,
                      onSaved: (value) {
                        _editedQuote = Quote(
                          quote: _editedQuote.quote,
                          author: _editedQuote.author,
                          id: _editedQuote.id,
                          comment: value,
                          isFavorite: _editedQuote.isFavorite,
                          type: _editedQuote.type,
                        );
                      },
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_typeFocusNode);
                      },
                      onEditingComplete: () {
                        setState(() {});
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
                      value: _selectedQuoteType != null
                          ? _selectedQuoteType
                          : _initValues['type'],
                      onSaved: (value) {
                        _editedQuote = Quote(
                          quote: _editedQuote.quote,
                          author: _editedQuote.author,
                          id: _editedQuote.id,
                          comment: _editedQuote.comment,
                          type: _quoteType(value),
                          isFavorite: _editedQuote.isFavorite,
                        );
                      },
                      focusNode: _typeFocusNode,
                      autovalidateMode: AutovalidateMode.always,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: _updateForm,
                          child: Text(
                            'Apply changes',
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

//   Navigator.of(context).pop();
// }
// setState(() {
//   _isLoading = false;
// });
// Navigator.pop(context);

// ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//     content: Text('Changes have been applied'),
//     duration: Duration(seconds: 2),
//   ),
// );
