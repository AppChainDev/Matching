import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';

class GroupPrefectureItem extends StatelessWidget {
  const GroupPrefectureItem(
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
      : AppColors.primaryWhite;
  }
  Color textColor(BuildContext context) {
    return inChecked
      ? AppColors.primaryWhite
      : AppColors.secondaryGray;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      margin: const EdgeInsets.only(right: 5, bottom: 7),
      decoration: BoxDecoration(
        color: backColor(context),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.secondaryGreen,
        )
      ),
      child: Center(
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