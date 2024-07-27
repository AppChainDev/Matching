import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';

class GroupOtherItem extends StatelessWidget {
  const GroupOtherItem(
    {required this.id,
    required this.text,
    required this.inChecked,
    super.key});

  final String text;
  final int id;
  final bool inChecked;

  Color backColor(BuildContext context) {
    return inChecked
      ? AppColors.secondaryGreen
      : AppColors.primaryGray;
  }
  Color textColor(BuildContext context) {
    return inChecked
      ? AppColors.primaryWhite
      : AppColors.secondaryGray;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 320.0,
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 6, right: 6, bottom: 7),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: backColor(context),
          borderRadius: BorderRadius.circular(10),
        ),
        child: CustomText(
          text: text, 
          fontSize: 14, 
          fontWeight: FontWeight.normal, 
          lineHeight: 1, 
          letterSpacing: -0.5, 
          color: textColor(context)
        ),
      ),
    );
  }
}