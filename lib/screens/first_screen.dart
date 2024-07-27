
import 'dart:io';

import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';

class FirstScreen extends StatelessWidget {

  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: BaseScreen(
        child: Stack(
          children: [
             Center(
               child: CustomContainer(
                 width: 375,
                 height: 812,
                 decoration: BoxDecoration(
                  color: AppColors.primaryWhite
                 ),
                 child: Padding(
                  padding: const EdgeInsets.only(bottom: 45),
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        title: "Appleでサインイン",
                        width: 316,
                        fontSize: 15, 
                        fontWeight: FontWeight.normal, 
                        color: AppColors.primaryBlack,
                        // borderColor: AppColors.primaryBlue, 
                        titleColor: AppColors.primaryWhite, 
                        onTap: (){
                          Navigator.pushNamed(context, "/phone");
                        }
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        title: "LINEでログイン",
                        width: 316,
                        fontSize: 15, 
                        fontWeight: FontWeight.normal, 
                        color: AppColors.primaryGreen,
                        titleColor: AppColors.primaryWhite, 
                        onTap: (){
                          Navigator.pushNamed(context, "/femalemypage");
                        }
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        title: "Facebookでログイン",
                        width: 316,
                        fontSize: 15, 
                        fontWeight: FontWeight.normal, 
                        color: AppColors.primaryBlue, 
                        titleColor: AppColors.primaryWhite, 
                        onTap: (){
                          Navigator.pushNamed(context, "/malemypage");
                        }
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        title: "電話番号でサインイン",
                        width: 316,
                        fontSize: 15, 
                        fontWeight: FontWeight.normal, 
                        color: AppColors.darkGray, 
                        titleColor: AppColors.primaryWhite, 
                        onTap: (){
                          
                        }
                      ),
                      const SizedBox(
                        height: 46,
                      ),
                      CustomText(
                        text: "登録・ログインにお困りの方へ", 
                        fontSize: 11, 
                        fontWeight: FontWeight.normal, 
                        lineHeight: 1, 
                        letterSpacing: 1, 
                        color: AppColors.primaryBlack
                      )
                    ],
                   ),
                 ),
               ),
             )
          ],
        )
      ),
    );
  }
}
