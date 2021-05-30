import 'package:flutter/material.dart';

class FloatButtonModal extends StatelessWidget {
  void _addUserInput(context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          child: Card(
            elevation: 5,
            child: Container(
              color: Theme.of(context).canvasColor,
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Author',
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Quote',
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Comment',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/quotes_screen');
                        },
                        child: Text(
                          'Add Quote',
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => _addUserInput(context),
    );
  }
}
