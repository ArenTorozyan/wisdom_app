import 'package:flutter/material.dart';
import 'package:mac_app/widgets/modalForm.dart';

class FloatModalWindow extends StatefulWidget {
  @override
  _FloatModalWindowState createState() => _FloatModalWindowState();
}

class _FloatModalWindowState extends State<FloatModalWindow> {
  void _addUserInput(context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return ModalSheet();
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

// Create a global key that uniquely identifies the Form widget
// and allows validation of the form.
//
// Note: This is a `GlobalKey<FormState>`,
// not a GlobalKey<MyCustomFormState>.
// final _formKey = GlobalKey<FormState>();
// final _quoteFocusNode = FocusNode();
// final _commentFocusNode = FocusNode();

// final _authorController = TextEditingController();
// final _quoteController = TextEditingController();
// final _commentController = TextEditingController();

// @override
// void dispose() {
//   _authorController.dispose();
//   _quoteController.dispose();
//   _commentController.dispose();
//   super.dispose();
// }
