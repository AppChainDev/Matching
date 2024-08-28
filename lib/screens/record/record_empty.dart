import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_button.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:flutter/material.dart';

class RecordEmptyScreen extends StatefulWidget {

  const RecordEmptyScreen({super.key});

  @override
  State<RecordEmptyScreen> createState() => _RecordEmptyScreenState();
}

class _RecordEmptyScreenState extends State<RecordEmptyScreen> {

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
              decoration: BoxDecoration(
                color: AppColors.primaryBackground
              ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage("assets/images/no_recordlist.png"),
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Text(
                        "他のユーザーに足跡をつけて\nマッチング率アップ！",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                          color: AppColors.primaryBlack
                        ),
                      )
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
                    padding: const EdgeInsets.only(bottom: 90),
                    child: CustomButton(
                      title: "足跡をつける",
                      width: 343,
                      height: 45,
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      color: AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () async{ 
                        Navigator.pushNamed(context, "/swipe");
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
                      text: "足跡", 
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
          ),
           Center(
            child: CustomContainer(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(top:46),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
          
        ],
      )
    );
  }
}
