import 'package:flutter/material.dart';

class MyTitleTextField extends StatelessWidget {
   final TextEditingController _textFieldController;
   final String _oldTitle;

  const MyTitleTextField(this._textFieldController, this._oldTitle, {super.key});


  @override
  Widget build(BuildContext context) {
    if(_oldTitle != "") {
      _textFieldController.text = _oldTitle;
    }

    return TextField(
        controller: _textFieldController,
        decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(0),
            counter: null,
            counterText: "",
            hintText: "Title",
            hintStyle: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                height: 1.5,
            ),
        ),
        maxLength: 32,
        maxLines: 1,
        style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            height: 1.5,
            color: Color(0xFF444444),
        ),
        textCapitalization: TextCapitalization.words,
    );
  }
}