import 'package:flutter/material.dart';
import 'dart:math';

import 'textOutput.dart';
import 'gradientButton.dart';
import '../widgets/actionButton.dart';

class TextControl extends StatefulWidget {
  @override
  _TextControlState createState() => _TextControlState();
}

class _TextControlState extends State<TextControl> {
  String _sentence =
      'In three words I can sum up everything I\'ve learned about life: it goes on. \n\n ― Robert Frost';

  final List _sentences = [
    'In three words I can sum up everything I\'ve learned about life: it goes on. \n\n ― Robert Frost',
    'Live as if you were to die tomorrow. Learn as if you were to live forever. \n\n ― Mahatma Gandhi',
    'Always forgive your enemies; nothing annoys them so much. \n\n ― Oscar Wilde',
    'If you tell the truth, you don\'t have to remember anything. \n\n ― Mark Twain',
    'You only live once, but if you do it right, once is enough. \n\n ― Mae West',
    'A friend is someone who knows all about you and still loves you. \n\n ― Elbert Hubbard',
    'It is our choices, Harry, that show what we truly are, far more than our abilities. \n\n ― J.K. Rowling, Harry Potter and the Chamber of Secrets',
    'The fool doth think he is wise, but the wise man knows himself to be a fool. \n\n ― William Shakespeare',
    'Fairy tales are more than true: not because they tell us that dragons exist, but because they tell us that dragons can be beaten. \n\n ― Neil Gaiman, Coraline',
    'Life is what happens to us while we are making other plans. \n\n ― Allen Saunders',
    'I have not failed. I\'ve just found 10,000 ways that won\'t work. \n\n ― Thomas A. Edison',
    'I like nonsense, it wakes up the brain cells. Fantasy is a necessary ingredient in living. \n\n ― Dr. Seuss',
    'Love all, trust a few, do wrong to none. \n\n ― William Shakespeare, All\'s Well That Ends Well',
    'Never put off till tomorrow what may be done day after tomorrow just as well. \n\n ― Mark Twain',
    'The man who does not read has no advantage over the man who cannot read. \n\n ― Mark Twain',
    'Women and cats will do as they please, and men and dogs should relax and get used to the idea. \n\n ― Robert A. Heinlein',
    'Sometimes the questions are complicated and the answers are simple. \n\n ― Dr. Seuss',
    'All you need is love. But a little chocolate now and then doesn\'t hurt. \n\n ― Charles M. Schulz',
    'You can never be overdressed or overeducated. \n\n ― Oscar Wilde',
    'Those who don\'t believe in magic will never find it. \n\n ― Roald Dahl',
    'An eye for an eye will only make the whole world blind. \n\n ― Mahatma Gandhi',
    'I would rather walk with a friend in the dark, than alone in the light. \n\n ― Helen Keller',
    'I speak to everyone in the same way, whether he is the garbage man or the president of the university. \n\n ― Albert Einstein',
    'The truth will set you free, but first it will piss you off. \n\n ― Joe Klaas',
    'Fate is like a strange, unpopular restaurant filled with odd little waiters who bring you things you never asked for and don\'t always like. \n\n ― Lemony Snicket',
    'Darkness cannot drive out darkness: only light can do that. Hate cannot drive out hate: only love can do that. \n\n ― Martin Luther King Jr. ',
  ];

  var _sentenceIndex = 0;

  var random = new Random();

  void _increaseIndex() {
    setState(() {
      _sentenceIndex++;
    });
  }

  void _decreaseIndex() {
    setState(() {
      _sentenceIndex--;
    });
  }

  void _setIndexInc() {
    setState(() {
      _sentenceIndex < (_sentences.length - 1)
          ? _increaseIndex()
          : _sentenceIndex = 0;
    });
  }

  void _setIndexDec() {
    setState(() {
      _sentenceIndex != 0
          ? _decreaseIndex()
          : _sentenceIndex = (_sentences.length - 1);
    });
  }

  void _setIndexRandom() {
    //does not work yet, since _sentenceIndex in if statemnt is equal to 0
    setState(() {
      var _newSentenceIndex;
      _newSentenceIndex = random.nextInt(_sentences.length - 1);
      if (_sentenceIndex == _newSentenceIndex) {
        _newSentenceIndex = random.nextInt(_sentences.length - 1);
      } else {
        _sentenceIndex = _newSentenceIndex;
      }
    });
  }

  void _getQuote() {
    setState(() {
      _sentence = _sentences[_sentenceIndex];
    });
  }

  void _randomQuote() {
    setState(
      () {
        _setIndexRandom();
        _getQuote();
      },
    );
  }

  void _previousQuote() {
    setState(
      () {
        _setIndexDec();
        _getQuote();
      },
    );
  }

  void _nextQuote() {
    setState(
      () {
        _setIndexInc();
        _getQuote();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 100,
                minHeight: 380,
                maxWidth: 350,
                maxHeight: 800,
              ),
              // child: Consumer<Quote>(
              //   child: Column(
              //     children: [
              child: TextOutput(_sentence),
              //     IconButton(
              //       icon: Icon(Icons.favorite_border),
              //       onPressed: () => quote.toggleFavoriteStatus(),
              //     ),
              //   ],
              // ),
            ),
          ),
          // ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: ActionButton(
                    _previousQuote, 'Prev', Colors.blue, Colors.white),
              ),
              ActionButton(_nextQuote, 'Next', Colors.red, Colors.white),
            ],
          ),
          GradientButton(_randomQuote, 'Random Quote', Colors.blue, Colors.red,
              Colors.white),
        ],
      ),
    );
  }
}
