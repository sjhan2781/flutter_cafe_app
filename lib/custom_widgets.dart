import 'package:cafe_watcha/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UnderLinedButton extends StatelessWidget {
  final String _text;
  final Function _onPressed;

  UnderLinedButton(this._text, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 12,
      onPressed: _onPressed,
      child: Text(
        _text,
        style: TextStyle(
            color: MyColor.fabIconColor,
            fontSize: 12,
            decoration: TextDecoration.underline,
            letterSpacing: 1),
      ),
    );
  }
}
