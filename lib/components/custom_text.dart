import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double? lineHeight;
  final double? letterSpacing;

  const CustomText({super.key, required this.text, required this.fontSize, required this.fontWeight, required this.lineHeight, required this.letterSpacing, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: lineHeight??1,
        letterSpacing: letterSpacing??1 
      ),
    );
  }
}
