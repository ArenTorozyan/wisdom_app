import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/quotes.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ignore: unused_field
  var _isLoading = false;

  var _isInit = true;

  @override
  void initState() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Quotes>(context, listen: false)
          .fetchAndSetFavoriteQuotes()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  'Collective Wisdom',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                child: Text('ENTER'),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/quotes_screen');
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  textStyle: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
