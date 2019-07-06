import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(            
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _textForm('Normal hour', false),
              Icon(Icons.arrow_forward),
              _textForm('Value', true),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _textForm('Extra hour', false),
              Icon(Icons.arrow_forward),
              _textForm('Value', true),
            ],
          )
        ],
      )
    );
  }
}

Widget _textForm (String text, bool money){
  return Expanded(
    flex: 1,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: money ? Icon(Icons.euro_symbol) : Icon(Icons.access_time),
          labelText: text
        ),
      )
    )
  );
}