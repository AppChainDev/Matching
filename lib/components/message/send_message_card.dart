import 'dart:io';

import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SendMessageItem extends StatelessWidget{
  const SendMessageItem({
    super.key, this.text, required this.date, this.image
  });

  final String? text;
  final String date;
  final File? image;
  String formatTime(DateTime date) {
    DateFormat timeFormat = DateFormat('HH:mm');
    return timeFormat.format(date);
  }

  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                text: formatTime(DateTime.parse(date)), 
                fontSize: 13, 
                fontWeight: FontWeight.normal, 
                lineHeight: 1, 
                letterSpacing: 1, 
                color: AppColors.secondaryGray
              ),
              if(text != null)
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 260.0,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryGreen,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: CustomText(
                      text: text!, 
                      fontSize: 15, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 1.5, 
                      letterSpacing: -1, 
                      color: AppColors.primaryWhite
                    ),
                  ),
                ),
              if(image != null)
                Container(
                  width: 235,
                  height: 145,
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(
                        image!,
                        scale: 1.0
                      ),
                      fit: BoxFit.cover
                    )
                  )
                ),
            ],
          ),
        ],
      ),
    );
  }
}