import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color color;
  final Color? borderColor;
  final Color titleColor;
  final FontWeight fontWeight;
  final VoidCallback onTap;

  const CustomButton({super.key, required this.title, required this.width, required this.fontSize, required this.fontWeight, required this.color, this.borderColor, required this.titleColor, required this.onTap, this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width,
      height: height ?? 48,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 2, color:borderColor ?? Colors.transparent)),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: titleColor),
        ),
      ),
    ),
  );
  }
}
