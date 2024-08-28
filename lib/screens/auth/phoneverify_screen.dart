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

class PhoneVerifyScreen extends StatefulWidget {

  const PhoneVerifyScreen({super.key});

  @override
  State<PhoneVerifyScreen> createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  final TextEditingController verifyController = TextEditingController();
    
  @override
  void initState() {
    super.initState();
    verifyController.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    verifyController.removeListener(_updateButtonColor);
    verifyController.dispose();
    super.dispose();
  }

  void _updateButtonColor() {
    setState(() {
    });
  }
  Future<void> phoneLogin(String phoneNumber) async{
    final isSend = await Provider.of<UserState>(context, listen: false).loginPhoneNumber(phoneNumber, verifyController.text);
    if (isSend) {
      Navigator.pushNamed(context, "/loginhome");
    } else {
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
                  "認証コードが正しくありません。\n正しい認証コードを入力してください。",
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
    final args = ModalRoute.of(context)!.settings.arguments as Phonenumber;
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
                    CustomText(
                      text: "届いた認証番号を入力",
                      fontSize: 24, 
                      fontWeight: FontWeight.normal, 
                      color: AppColors.primaryBlack,
                      lineHeight: 1,
                      letterSpacing: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: "下記電話番号宛に届いた認証コードを入力してください。",
                      fontSize: 14, 
                      fontWeight: FontWeight.normal, 
                      color: AppColors.primaryBlack,
                      lineHeight: 1,
                      letterSpacing: -1.5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.trip_origin,
                          color: AppColors.primaryBlack,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        CustomText(
                          text: args.num,
                          fontSize: 14, 
                          fontWeight: FontWeight.normal, 
                          color: AppColors.primaryBlack,
                          lineHeight: 1,
                          letterSpacing: 1,
                        )
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
                            controller: verifyController,
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
                      color: verifyController.text.isEmpty?AppColors.secondaryGreen.withOpacity(0.5):AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () async{ 
                        phoneLogin(args.num);
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
                      // icon: Image.asset("assets/images/black_backmark.png", fit: BoxFit.cover,)
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
