
import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VerifyWaitingScreen extends StatefulWidget {

  const VerifyWaitingScreen({super.key});

  @override
  State<VerifyWaitingScreen> createState() => _VerifyWaitingScreenState();
}

class _VerifyWaitingScreenState extends State<VerifyWaitingScreen> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future moveProfile() async{
    const storage = FlutterSecureStorage();
    String? gender =  await storage.read(key: 'gender');
    if (gender != null) {
      // ignore: unrelated_type_equality_checks
      if (int.parse(gender) == 1) {
        Navigator.pushNamed(context, "/malemypage");
      } else {
        Navigator.pushNamed(context, "/femalemypage");
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Stack(
        children: [
           Center(
            child: CustomContainer(
              decoration: BoxDecoration(
                color: AppColors.primaryBackground
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 208),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset("assets/images/waiting.png", fit: BoxFit.cover),
                          const SizedBox(
                            height: 45,
                          ),
                          CustomText(
                            text: "ご提出いただいた公的書類を確認しております", 
                            fontSize: 13, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1.5, 
                            letterSpacing: -1, 
                            color: AppColors.primaryBlack
                          ),
                          CustomText(
                            text: "通常1〜2日営業日以内に審査は完了します", 
                            fontSize: 13, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1.5, 
                            letterSpacing: -1, 
                            color: AppColors.primaryBlack
                          )
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
           ),
           Center(
            child: CustomContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: CustomButton(
                      title: "戻る",
                      width: 343,
                      height: 45,
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      color: AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () { 
                        moveProfile();
                      }
                    ),
                  ),
                ],
              ),
            ),
           ),
           Center(
            child: CustomContainer(
              height: 94,
              decoration: BoxDecoration(
                color: AppColors.secondaryGreen
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      text: "本人確認", 
                      fontSize: 17, 
                      fontWeight: FontWeight.bold, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color:AppColors.primaryWhite
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
