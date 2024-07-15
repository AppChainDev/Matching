import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';

class AgreementItem extends StatelessWidget{
  const AgreementItem({
    super.key, required this.name, required this.prefectureId, required this.age, required this.description, required this.bgImage, required this.avatarImage
 });

 final String name;
 final int prefectureId;
 final int age;
 final String description;
 final String bgImage;
 final String avatarImage;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top:25),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 440,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage("assets/images/$bgImage"),
                fit: BoxFit.cover     
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 440,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.primaryBlack.withOpacity(0.5),
                ],
              ),
              
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 43,
                                      height: 43,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: Image.asset("assets/images/$avatarImage", fit:BoxFit.cover),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: "ゆうた", 
                                          fontSize: 16, 
                                          fontWeight: FontWeight.bold, 
                                          lineHeight: 1.5, 
                                          letterSpacing: 1, 
                                          color: AppColors.primaryWhite
                                        ),
                                        Row(
                                          children: [
                                            CustomText(
                                              text: "$age歳", 
                                              fontSize: 16, 
                                              fontWeight: FontWeight.bold, 
                                              lineHeight: 1.5, 
                                              letterSpacing: 1, 
                                              color: AppColors.primaryWhite
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            CustomText(
                                              text: ConstFile.prefectureItems[prefectureId], 
                                              fontSize: 10, 
                                              fontWeight: FontWeight.normal, 
                                              lineHeight: 1.5, 
                                              letterSpacing: 1, 
                                              color: AppColors.primaryWhite
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CustomText(
                                  text: description, 
                                  fontSize: 14, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1.5, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryWhite
                                )
                              ],
                            ),
                          )
                          
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
      
        ],
      ),
    );
  }
}