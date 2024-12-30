import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPress;

  const AuthGradientButton({required this.buttonText,required this.onPress, super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
        AppPallete.gradient1,
        AppPallete.gradient2,
      ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
      child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            fixedSize: Size(screenWidth, 60),
            backgroundColor: AppPallete.transparentColor,
            shadowColor: AppPallete.transparentColor,
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )),
    );
  }
}
