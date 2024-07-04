import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';

class CandidateItem extends StatelessWidget{
  const CandidateItem({
    super.key, required this.name, required this.text
 });

 final String name;
 final String text;

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryGray.withOpacity(0.5), // Shadow color
            spreadRadius: 0.5, // Spread radius
            blurRadius: 5, // Blur radius
            offset: const Offset(0, 1), // Shadow position (x, y)
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: () {
          
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: AppColors.primaryBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomText(
                text: text, 
                fontSize: 13, 
                fontWeight: FontWeight.normal, 
                lineHeight: 2, 
                letterSpacing: -1, 
                color: AppColors.primaryBlack
              )
            ],
          ),
        ),
      ),
    );
  }
}