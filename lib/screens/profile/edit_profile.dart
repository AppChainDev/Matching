import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/screens/profile/component/groupedit_component.dart';
import 'package:drone/screens/profile/component/introdcution_component.dart';
import 'package:drone/screens/profile/component/mainphoto_component.dart';
import 'package:drone/screens/profile/component/memoriesimage_component.dart';
import 'package:drone/screens/profile/component/profileinformation_component.dart';
import 'package:drone/screens/profile/component/question_component.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

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
      child: CustomContainer(
        decoration: BoxDecoration(
          color: AppColors.primaryGray.withOpacity(0.5)
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              const Center(
                child: Column(
                  children: [
                    MainPhoto(
                      id: 1, 
                      avatarList: ["gfd.png", "" ,"", "", ""]
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    IntroductionWidget(),
                    SizedBox(
                      height: 30,
                    ),
                    QuestionsWidget(),
                    SizedBox(
                      height: 17,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MemoryImageWidget(),
                    SizedBox(
                      height: 24,
                    ),
                    ProfileInformationWidget(),
                    SizedBox(
                      height: 17,
                    ),
                    GroupEditWidget()
                    
                  ],
                ),
              ),
              Center(
                child: CustomContainer(
                  height: 94,
                  decoration: BoxDecoration(
                    color: AppColors.primaryWhite
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          text: "プロフィール編集", 
                          fontSize: 17, 
                          fontWeight: FontWeight.bold, 
                          lineHeight: 1, 
                          letterSpacing: 1, 
                          color: AppColors.primaryBlack
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          }, 
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: AppColors.primaryBlack,
                          )
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/view_profile');
                          }, 
                          child: CustomText(
                            text: "相手からの見え方", 
                            fontSize: 10, 
                            fontWeight: FontWeight.bold, 
                            lineHeight: 1, 
                            letterSpacing: -1, 
                            color: AppColors.secondaryGreen
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

