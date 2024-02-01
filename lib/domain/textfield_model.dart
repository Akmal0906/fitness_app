import 'package:flutter/cupertino.dart';

class TextFieldModel {
  final String hintText;
  bool obscureText;
  final TextEditingController controller;
  final bool isNeed;

  TextFieldModel(
      {required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.isNeed});
}
