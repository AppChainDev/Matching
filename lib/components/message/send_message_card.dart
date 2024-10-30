import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class SendMessageItem extends StatelessWidget{
  const SendMessageItem({
    super.key, this.text, required this.date, this.image
  });

  final String? text;
  final String date;
  final String? image;
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
              if(text != null && text != "")
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
                      image: NetworkImage("${dotenv.get('BASE_URL')}/img/$image"),
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