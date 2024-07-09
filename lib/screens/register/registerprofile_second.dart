import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterProfileSecondScreen extends StatefulWidget {

  const RegisterProfileSecondScreen({super.key});

  @override
  State<RegisterProfileSecondScreen> createState() => _RegisterProfileSecondScreenState();
}

class _RegisterProfileSecondScreenState extends State<RegisterProfileSecondScreen> {

  final TextEditingController birthdayController = TextEditingController();
   final int maxAge = 40;
   int age = 0;

  @override
  void initState() {
    super.initState();
    birthdayController.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    birthdayController.removeListener(_updateButtonColor);
    birthdayController.dispose();
    super.dispose();
  }

  void _updateButtonColor() {
    setState(() {

    });
  }
  void onBirthdayChange(DateTime birthday) {
    final now = DateTime.now();
    int value = now.year - birthday.year - (now.month < birthday.month || (now.month == birthday.month && now.day < birthday.day) ? 1 : 0);
    setState(() {
      age = value;
      birthdayController.text = DateFormat('yyyy-MM-dd').format(birthday);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Stack(
        children: [
          Center(
             child: CustomContainer(
              decoration: BoxDecoration(
                color: AppColors.primaryWhite
              ),
               child: Column(
                 children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 108, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "生年月日を教えてください", 
                          fontSize: 24, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: -2, 
                          color: AppColors.primaryBlack
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CustomText(
                          text: "後から変更することはできません\n本人確認の際に照合するため、正しく入力してください。", 
                          fontSize: 12, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1.5, 
                          letterSpacing: -1, 
                          color: AppColors.primaryBlack
                        ),
                        const SizedBox(
                          height: 75,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircleAvatar(
                                  radius: 10,
                                  foregroundColor: AppColors.primaryWhite,
                                  backgroundColor: birthdayController.text.isNotEmpty?AppColors.secondaryGreen:AppColors.secondaryGray,
                                  child: ImageIcon(
                                    const AssetImage("assets/images/tick.png"),
                                    color: AppColors.primaryWhite,
                                  )
                                ),
                              )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                 ],
               ),
             ),
           ),
           Center(
            child: CustomContainer(
              child: Padding(
                padding: const EdgeInsets.only(top:270),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:45, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2.0,
                                  color: AppColors.secondaryGreen
                                )
                              )
                            ),
                            child: TextField(
                              readOnly: true,
                              controller: birthdayController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(15)
                              ),
                              onTap: () async {
                                FocusScope.of(context).requestFocus(FocusNode());
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext builder) {
                                      return Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryWhite,
                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                                          ),
                                          height: MediaQuery.of(context).copyWith().size.height / 3,
                                          child: CupertinoDatePicker(
                                            backgroundColor: AppColors.primaryWhite,
                                            
                                            initialDateTime: DateTime.now(),
                                            onDateTimeChanged:(value) {
                                              onBirthdayChange(value);
                                            },
                                            mode: CupertinoDatePickerMode.date,
                                          ));
                                    });
                              },
                            ),
                          )  
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            )
          ),
           Center(
            child: CustomContainer(
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
                      color: birthdayController.text.isEmpty?AppColors.secondaryGreen.withOpacity(0.5):AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () async{                        
                        if (age > maxAge) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(''),
                                content: Text('$maxAge歳以上のお客様はご利用いただけません。'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          Navigator.pushNamed(context, "/registerprofile_third");                                 
                        }
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
                      text: "プロフィール登録", 
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
