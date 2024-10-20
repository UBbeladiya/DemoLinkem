import 'package:flutter/material.dart';

import '../Constant.dart';

InputDecoration TextFiledInputDecoration({required String hintText, required String labelText}) {
  return InputDecoration(
    labelText: null,
    hintText: hintText,
    counterStyle: TextStyle(color: primaryText),

    labelStyle: TextStyle(
      fontFamily: 'Readex Pro',
      letterSpacing: 0.0,
    ),
    hintStyle: TextStyle(
      fontFamily: 'Readex Pro',
      letterSpacing: 0.0,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFBDBDBD),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: primaryText,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: errorColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: errorColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

TextStyle titleText({required Color color}){
  return TextStyle(
    fontFamily: 'Readex Pro',
    letterSpacing: 0.0,
    color: color
  );
}