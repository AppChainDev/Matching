import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class ReceivedMessageItem extends StatelessWidget{
  const ReceivedMessageItem({
    super.key, required this.text, required this.avatar, required this.date, this.image,
  });

  final String text;
  final String avatar;
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
        mainAxisAlignment:MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 43,
                height: 43,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/$avatar"),
                    fit: BoxFit.cover
                  )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 200.0, // Set the maximum width
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhite,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: CustomText(
                        text: text, 
                        fontSize: 15, 
                        fontWeight: FontWeight.normal, 
                        lineHeight: 1.5, 
                        letterSpacing: -1, 
                        color: AppColors.primaryBlack
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomText(
                    text: formatTime(DateTime.parse(date)), 
                    fontSize: 13, 
                    fontWeight: FontWeight.normal, 
                    lineHeight: 1, 
                    letterSpacing: 1, 
                    color: AppColors.secondaryGray
                  )
                ],
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