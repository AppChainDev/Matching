import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/phone_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneScreen extends StatefulWidget {

  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController phoneController = TextEditingController();
  final int minPhoneNumberLength = 7;  // Set your minimum length here
  final int maxPhoneNumberLength = 15; // Set your maximum length here

  @override
  void initState() {
    super.initState();
    phoneController.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    phoneController.removeListener(_updateButtonColor);
    phoneController.dispose();
    super.dispose();
  }

  void _updateButtonColor() {
    setState(() {

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
               child: Padding(
                padding: const EdgeInsets.only(top: 108, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "電話番号を入力",
                          fontSize: 24, 
                          fontWeight: FontWeight.normal, 
                          color: AppColors.primaryBlack,
                          lineHeight: 1,
                          letterSpacing: 1,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "入力した電話番号に６桁の認証番号が届きます。",
                          fontSize: 14, 
                          fontWeight: FontWeight.normal, 
                          color: AppColors.primaryBlack,
                          lineHeight: 1,
                          letterSpacing: -1,
                        ),
                      ],
                    ),
                  ],
                )
               ),
             ),
           ),
          Center(
            child: CustomContainer(
              child: Padding(
                padding: const EdgeInsets.only(top:250),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: phoneController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            cursorColor: AppColors.primaryBlack,
                            style: TextStyle(
                              color:AppColors.primaryBlack
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsets.all(15),
                              fillColor: AppColors.textFieldColor.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          CustomText(
                            text: "次の画面で入力した電話番号に認証番号が届きます。", 
                            fontSize: 12, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1, 
                            letterSpacing: -0.5, 
                            color: AppColors.primaryBlack
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
              child: Padding(
                padding: const EdgeInsets.only(top:460, left:20, right: 20),
                child: Column(
                  children: [
                    CustomButton(
                      title: "つぎへ",
                      width: 343,
                      height: 45,
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      color: phoneController.text.isEmpty?AppColors.secondaryGreen.withOpacity(0.5):AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () async{ 
                        // Navigator.pushNamed(context, "/findpilot");
                        // final isAuthenticated = Provider.of<UserState>(context, listen: false).isAuthenticated;
                        // if (isAuthenticated) {
                        //   if(Provider.of<UserState>(context, listen: false).user?.isPilot == false){
                        //     await Provider.of<UserState>(context, listen: false).login(emailController.text, passwordController.text);     
                        //   }
                        // }
                        if (phoneController.text.length < minPhoneNumberLength || phoneController.text.length > maxPhoneNumberLength) {  
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Padding(
                                padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
                                child:CustomText(
                                  text: "正しい電話番号を入力してください。", 
                                  fontSize: 18, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1.5, 
                                  letterSpacing: 1, 
                                  color: AppColors.primaryBlack
                                )
                              ),
                              actions: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        width: 2,
                                        color: AppColors.primaryGray
                                      )
                                    )
                                  ),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        }, 
                                        child: CustomText(
                                          text: "OK", 
                                          fontSize: 20, 
                                          fontWeight: FontWeight.bold, 
                                          lineHeight: 1, 
                                          letterSpacing: 1, 
                                          color: AppColors.primaryBlue
                                        )
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          Navigator.pushNamed(context, "/phoneverify", arguments: Phonenumber(num: phoneController.text));
                        }
                      }
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
                padding: const EdgeInsets.only(top:24, left:10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryBlack,
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
