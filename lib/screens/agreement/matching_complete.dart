
import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/matching_model.dart';
import 'package:flutter/material.dart';

class MatchingCompleteScreen extends StatefulWidget {

  const MatchingCompleteScreen({super.key});

  @override
  State<MatchingCompleteScreen> createState() => _MatchingCompleteScreenState();
}

class _MatchingCompleteScreenState extends State<MatchingCompleteScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MatchingModel;
    return BaseScreen(
      child: Stack(
        children: [
          Center(
            child: CustomContainer(
              child: Image.asset("assets/images/matching_complete_back.png", fit: BoxFit.cover,),
            )
          ),
          Center(
             child: CustomContainer(
              child: Padding(
                padding: const EdgeInsets.only(top: 170),
                child: Column(
                  children: [
                    Container(
                      width: 132,
                      height: 132,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image.asset("assets/images/${args.avatar}", fit:BoxFit.cover),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      "${args.name}さんと\nマッチングしました",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryWhite,
                        fontSize: 19,
                        fontWeight: FontWeight.normal,
                        letterSpacing: -1
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText(
                      text: '早速メッセージしてみましょう', 
                      fontSize: 16, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 1, 
                      letterSpacing: -1, 
                      color: AppColors.primaryWhite
                    )
                  ],
                ),
              ),
             ),
           ),
          Center(
            child: CustomContainer(
              decoration: const BoxDecoration(
                color: Colors.transparent
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Column(
                      children: [
                        CustomButton(
                          title: "メッセージする",
                          width: 343,
                          height: 45,
                          fontSize: 17, 
                          fontWeight: FontWeight.normal, 
                          color: AppColors.primaryWhite, 
                          titleColor: AppColors.secondaryGreen, 
                          onTap: () { 
                            
                          }
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                          title: "とじる",
                          width: 343,
                          height: 45,
                          fontSize: 17, 
                          fontWeight: FontWeight.normal, 
                          color: Colors.transparent, 
                          titleColor: AppColors.primaryWhite, 
                          onTap: () {
                            Navigator.pop(context);  
                          }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
           ),
           
          
        ],
      )
    );
  }
}
