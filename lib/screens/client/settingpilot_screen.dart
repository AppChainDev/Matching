
import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';

class SettingPilotScreen extends StatelessWidget {
  const SettingPilotScreen({super.key});

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
                "assets/images/white_back.png",
                fit: BoxFit.cover
              ),
             ),
           ),
           Center(
            child: CustomContainer(
              width: 375.0,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(top:30, left:20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        icon: Image.asset("assets/images/back_settingicon.png", fit: BoxFit.cover,)
                      ),
                    ),
                  ],
                ),
              ),
            ),
           ),
           Center(
             child: CustomContainer(
               width: 375,
               height: 812,
               child: Padding(
                padding: const EdgeInsets.only(top: 112, left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.secondaryGray.withOpacity(0.5),
                            width: 1
                          )
                        )
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "アカウント情報の編集", 
                              fontSize: 14, 
                              fontWeight: FontWeight.bold, 
                              lineHeight: 1, 
                              letterSpacing: 1, 
                              color: AppColors.primaryBlack
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.primaryBlack,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top:20, bottom: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.secondaryGray.withOpacity(0.5),
                            width: 1
                          )
                        )
                      ),
                      child: MaterialButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "ポートフォリオの編集", 
                              fontSize: 14, 
                              fontWeight: FontWeight.bold, 
                              lineHeight: 1, 
                              letterSpacing: 1, 
                              color: AppColors.primaryBlack
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.primaryBlack,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:20, bottom: 20),
                      child: MaterialButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "銀行口座情報の編集", 
                              fontSize: 14, 
                              fontWeight: FontWeight.bold, 
                              lineHeight: 1, 
                              letterSpacing: 1, 
                              color: AppColors.primaryBlack
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.primaryBlack,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
               ),
             ),
           ),
           
        ],
      )
    );
  }
}
