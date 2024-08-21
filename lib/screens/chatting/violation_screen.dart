import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/chattingtransfer_model.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class ViolationScreen extends StatelessWidget {
  const ViolationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ChattingTransferModel;
    return BaseScreen(
      child: Stack(
        children: [
          Center(
            child: CustomContainer(
              decoration: BoxDecoration(
                color: AppColors.primaryBackground
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:150),
                child: Column(
                  children: [
                    CustomText(
                      text: "下記のユーザーを違反報告しますか？", 
                      fontSize: 14, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 1, 
                      letterSpacing: -1, 
                      color: AppColors.primaryBlack
                    ),
                    Container(
                      width: 87,
                      height: 87,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: NetworkImage("${dotenv.get('BASE_URL')}/img/${args.avatar}"),
                          fit: BoxFit.cover,  
                        ) 
                      ),
                    ),
                    CustomText(
                      text: args.name, 
                      fontSize: 16, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 2, 
                      letterSpacing: 1, 
                      color: AppColors.primaryBlack
                    ),
                    CustomText(
                      text: "${ConstFile.prefectureItems[args.prefectureId]} ${args.age}歳", 
                      fontSize: 12, 
                      fontWeight: FontWeight.normal, 
                      lineHeight:   2, 
                      letterSpacing: 1, 
                      color: AppColors.secondaryGray
                    ),
                    const SizedBox(
                      height: 85,
                    ),
                    Text(
                      "報告後に運営サポートにより\n会員調査を行います",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryBlack,
                        height: 1.5
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                CustomContainer(
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
                          text: "違反報告", 
                          fontSize: 17, 
                          fontWeight: FontWeight.bold, 
                          lineHeight: 1, 
                          letterSpacing: 1, 
                          color: AppColors.primaryWhite
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: CustomContainer(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(top:46),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppColors.primaryWhite,
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: CustomContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 79),
                    child: CustomButton(
                      title: "通報する",
                      width: 343,
                      height: 45,
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      color: AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () async{ 
                        Navigator.pushNamed(context, "/violationconfirm_screen");
                      }
                    ),
                  ),
                ],
              ),
            ),
           ),
        ],
      ),
    );
  }
}
