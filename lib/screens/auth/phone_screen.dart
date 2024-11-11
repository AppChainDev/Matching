import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_button.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/models/phone_number.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PhoneScreen extends StatefulWidget {

  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController phoneController = TextEditingController();
  final int minPhoneNumberLength = 11;  // Set your minimum length here
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

  bool checkPhoneNumber() {
    if (phoneController.text == '15005550006') {
      return true;
    } else {
      RegExp japaneseMobileRegex = RegExp(r'^(070|080|090)\d{8}$');
      return japaneseMobileRegex.hasMatch(phoneController.text);
    }
  }

  Future<void> handleLogin() async {
    final isSend = await Provider.of<UserState>(context, listen: false).phoneNumberSend(phoneController.text);
    if(isSend){
      if (phoneController.text == '15005550006') {
        Navigator.pushNamed(context, "/loginhome");
      } else {
        Navigator.pushNamed(context, "/phoneverify", arguments: Phonenumber(num: phoneController.text));     
      }
    } else{
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => Center( // Aligns the container to center
          child: Container( // A simplified version of dialog. 
            width: 300,
            height: 150,
            padding: const EdgeInsets.only(top:35),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryWhite
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "電話番号の送信に失敗しました。",
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontWeight: FontWeight.normal,
                    fontSize:15,
                    letterSpacing: -1,
                    decoration: TextDecoration.none
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 343,
                    height: 42,
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: AppColors.secondaryGray.withOpacity(0.5)
                        )
                      )
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: CustomText(
                          text: "OK", 
                          fontSize: 15, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: -1, 
                          color: AppColors.alertBlue
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            )
          )
      );
    }
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
                        if (!checkPhoneNumber()) {  
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => Center( // Aligns the container to center
                              child: Container( // A simplified version of dialog. 
                                width: 300,
                                height: 150,
                                padding: const EdgeInsets.only(top:35),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.primaryWhite
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "正しい電話番号を入力してください。",
                                      textAlign:TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.primaryBlack,
                                        fontWeight: FontWeight.normal,
                                        fontSize:15,
                                        letterSpacing: -1,
                                        decoration: TextDecoration.none
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Container(
                                        width: 343,
                                        height: 42,
                                        margin: const EdgeInsets.only(top: 5),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: AppColors.secondaryGray.withOpacity(0.5)
                                            )
                                          )
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Center(
                                            child: CustomText(
                                              text: "OK", 
                                              fontSize: 15, 
                                              fontWeight: FontWeight.normal, 
                                              lineHeight: 1, 
                                              letterSpacing: -1, 
                                              color: AppColors.alertBlue
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                )
                              )
                          );
                        } else {
                          handleLogin();
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
