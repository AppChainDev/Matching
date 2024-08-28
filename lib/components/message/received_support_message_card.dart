import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:flutter/material.dart';

class ReceivedSupportMessageItem extends StatelessWidget{
  const ReceivedSupportMessageItem({
    super.key, required this.text,
 });

 final String text;

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 330,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryGray,
              borderRadius: BorderRadius.circular(10)
            ),
            child: CustomText(
              text: text, 
              fontSize: 13, 
              fontWeight: FontWeight.normal, 
              lineHeight: 1.5, 
              letterSpacing: 1, 
              color: AppColors.primaryBlack
            ),
          ),
        ],
      ),
    );
  }
}