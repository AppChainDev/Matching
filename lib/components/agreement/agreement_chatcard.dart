import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/matching_model.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';

class AgreementChatItem extends StatelessWidget{
  const AgreementChatItem({
    super.key, required this.name, required this.prefectureId, required this.age, required this.description, required this.avatarImage, required this.id
 });

 final int id;
 final String name;
 final int prefectureId;
 final int age;
 final String description;
 final String avatarImage;

  @override
  Widget build(BuildContext context){
    return Container(
      width: 330,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryGray.withOpacity(0.5), // Shadow color
            spreadRadius: 0.5, // Spread radius
            blurRadius: 5, // Blur radius
            offset: const Offset(0, 1), // Shadow position (x, y)
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left:10, right: 10, top:6, bottom: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.primaryGray,
                    width: 2
                  )
                ),
              ),
              child: Container(
                width: 322,
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 39,
                          height: 39,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: Image.asset("assets/images/$avatarImage", fit:BoxFit.cover),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          text: name, 
                          fontSize: 14, 
                          fontWeight: FontWeight.bold, 
                          lineHeight: 1, 
                          letterSpacing: 1, 
                          color: AppColors.primaryBlack
                        )
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: "$age歳", 
                          fontSize: 13, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: 1, 
                          color: AppColors.secondaryGray
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        CustomText(
                          text: ConstFile.prefectureItems[prefectureId], 
                          fontSize: 13, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: 1, 
                          color: AppColors.secondaryGray
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 6, right: 6, top: 14),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: description, 
                    fontSize: 13, 
                    fontWeight: FontWeight.normal, 
                    lineHeight: 1.5, 
                    letterSpacing: -1, 
                    color: AppColors.primaryBlack
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    title: "マッチングしてみる", 
                    width: 300,
                    height: 40, 
                    fontSize: 12, 
                    fontWeight: FontWeight.normal, 
                    color: AppColors.secondaryGreen, 
                    titleColor: AppColors.primaryWhite, 
                    onTap: (){
                      Navigator.pushNamed(context, "/matching_complete", arguments: MatchingModel(id: id, avatar: avatarImage, name: name));
                    }
                  )
                ]
              )
            )
          ],
        ),
      )
    );
  }
}