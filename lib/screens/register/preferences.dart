import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:flutter/material.dart';

class PreferenceScreen extends StatefulWidget {

  const PreferenceScreen({super.key});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {

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
    return BaseScreen(
      child: Stack(
        children: [
          Center(
            child: CustomContainer(
              child: Image.asset("assets/images/preference_back.png", fit: BoxFit.cover,),
            )
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
                    padding: const EdgeInsets.only(bottom: 22),
                    child: CustomButton(
                      title: "つぎへ",
                      width: 343,
                      height: 45,
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      color: AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () { 
                          Navigator.pushNamed(context, "/introduce");
                        // if(isCompleted()){
                        //   Navigator.pushNamed(context, "/registerprofile_photo");
                        // }     
                      }
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

