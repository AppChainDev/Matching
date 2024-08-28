import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_button.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:flutter/material.dart';
class ViolationConfirmScreen extends StatelessWidget {
  const ViolationConfirmScreen({super.key});

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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/thumb.png"),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomText(
                      text: "通報を受け付けました", 
                      fontSize: 14, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 1, 
                      letterSpacing: -1, 
                      color: AppColors.primaryBlack
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 79),
                    child: CustomButton(
                      title: "もどる",
                      width: 343,
                      height: 45,
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      color: AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () async{ 
                        Navigator.pop(context);
                        Navigator.pop(context);
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
