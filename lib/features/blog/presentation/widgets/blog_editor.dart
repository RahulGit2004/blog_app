import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const BlogEditor(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.trim().isEmpty) {
            return "$hintText is missing";
          }
          return null;
        },
        decoration: InputDecoration(hintText: hintText),
    maxLines: null,
    );
  }
}
