import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/utils/const_file.dart';
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

typedef CartChangedCallback = Function(int id);

class GroupItem extends StatelessWidget {
  const GroupItem({super.key, required this.inChecked, required this.id, required this.text, required this.image});
  
  final int id;
  final String image;
  final String text;
  final bool inChecked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            width: 95,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/$image",
                  fit: BoxFit.cover
                ),
                if(inChecked)
                  Center(
                    child: SizedBox(
                      width: 34,
                      height: 34,
                      child: Image.asset(
                        "assets/images/select.png",
                        fit: BoxFit.cover
                      )
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomText(
            text: text, 
            fontSize: 9, 
            fontWeight: FontWeight.normal, 
            lineHeight: 1, 
            letterSpacing: 1, 
            color: AppColors.primaryBlack
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
