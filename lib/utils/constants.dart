import 'dart:ui';

import 'package:flutter/material.dart';

abstract class AllText{
  static const String splash='FindSport';
  static const String username='Enter your first name';
  static const String lastName='Enter your last name';
  static const String phone='+998';
  static const String password='Enter your password';
  static const String repassword='Enter your confirm password';
  static const String save='Save';
  static const String signIn='Sign In';
}

TextStyle customStyle=const TextStyle(color: Colors.black,fontFamily: 'TextFont',fontSize: 14,);

List textList=['First Name','Last Name','Phone number','Password','Confirm password'];