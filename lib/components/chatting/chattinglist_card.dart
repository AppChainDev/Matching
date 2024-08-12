import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/usertransfer_model.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChattingListItem extends StatelessWidget{
  const ChattingListItem({
    super.key, required this.id, required this.name, required this.prefectureId, required this.age, required this.stateText, required this.avatar, required this.date, required this.state
 });

 final int id;
 final String name;
 final int prefectureId;
 final int age;
 final String avatar;
 final String state;
 final String stateText;
 final String date;

  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 8, right: 16, top: 20, bottom: 16),
      decoration: BoxDecoration(
        color: state=="receive"?AppColors.primaryBackground:AppColors.primaryWhite,
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryGray,
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/view_profile", arguments: UserTransforIdModel(null, id: id, beforePage: 'chattingpage'));
            },
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: AssetImage("assets/images/$avatar"),
                  fit: BoxFit.cover 
                )
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width-104,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: name, 
                          fontSize: 14, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1.5, 
                          letterSpacing: 1, 
                          color: AppColors.primaryBlack
                        ),
                        CustomText(
                          text: "${ConstFile.prefectureItems[prefectureId]} $age歳", 
                          fontSize: 11, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1.5, 
                          letterSpacing: 1, 
                          color: AppColors.primaryBlack
                        )
                      ],
                    ),
                    CustomText(
                      text: DateFormat('M/d HH:mm').format(DateTime.parse(date)), 
                      fontSize: 11, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 1.5, 
                      letterSpacing: -0.5, 
                      color: AppColors.secondaryGray
                    )
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                CustomText(
                  text: stateText, 
                  fontSize: 14, 
                  fontWeight: FontWeight.normal, 
                  lineHeight: 1, 
                  letterSpacing: -1, 
                  color: AppColors.secondaryGreen
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}