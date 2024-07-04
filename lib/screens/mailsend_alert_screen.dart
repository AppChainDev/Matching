
import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';

class MailSendAlertScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  MailSendAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Stack(
        children: [
           Center(
             child: CustomContainer(
              width: 375.0,
              height: 812.0,
              child: Image.asset(
                "assets/images/black_back.png",
                fit: BoxFit.cover
              ),
             ),
           ),
           Center(
             child: Padding(
              padding: const EdgeInsets.only(top: 44),
              child: CustomText(
                text: "ユーザー登録",
                fontSize: 16, 
                fontWeight: FontWeight.bold, 
                color: AppColors.primaryWhite,
                lineHeight: 1,
                letterSpacing: 1,
              )
             ),
           ),
           Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 189),
              child: Image.asset("assets/images/plane.png"),
            ),
           ),
           Center(
             child: CustomContainer(
               width: 375,
               height: 812,
               child: Padding(
                padding: const EdgeInsets.only(top: 400, left: 41,),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "メールを送信しました\n", 
                      fontSize: 13, 
                      fontWeight: FontWeight.bold, 
                      color: AppColors.primaryWhite,
                      lineHeight: 1.5,
                      letterSpacing: 1,
                    ),
                    CustomText(
                      text: "2時間以内にメール本文に記載のURLを\nクリックしてください。", 
                      fontSize: 13, 
                      fontWeight: FontWeight.bold, 
                      color: AppColors.primaryWhite,
                      lineHeight: 2,
                      letterSpacing: 1,
                    ),
                  ],
                 ),
               ),
             ),
           )
        ],
      )
    );
  }
}
