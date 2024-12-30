import 'package:flutter/cupertino.dart';

class CustomException implements Exception {
  String message;
  CustomException(this.message);
}