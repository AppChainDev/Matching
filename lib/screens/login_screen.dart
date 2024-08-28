import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_button.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/models/user_model.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserModel? userData;
  LoginScreen({super.key});

  // Future<void> handleLogin(BuildContext context) async {
  //   await Provider.of<UserState>(context, listen: false).login(emailController.text, passwordController.text);     
  //   userData = Provider.of<UserState>(context, listen: false).user;
  // }
  
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Stack(
        children: [
          Center(
            child: CustomContainer(
              child: Image.asset("assets/images/login_screen_back.png", fit: BoxFit.cover,),
            )
          ),
          Center(
             child: Padding(
              padding: const EdgeInsets.only(top: 44),
              child: CustomText(
                text: "ログイン",
                fontSize: 16, 
                fontWeight: FontWeight.bold, 
                color: AppColors.primaryWhite,
                lineHeight: 1.5,
                letterSpacing: 1,
              )
             ),
           ),
          Center(
            child: CustomContainer(
              child: Padding(
                padding: const EdgeInsets.only(top:303),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          TextField(
                            controller: emailController,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.text,
                            cursorColor: AppColors.primaryWhite,
                            style: TextStyle(
                              color:AppColors.primaryWhite
                            ),
                            decoration: InputDecoration(
                              hintText: "Eメールアドレス",
                              hintStyle: const TextStyle(
                                color: Color.fromRGBO(112, 112, 112, 1)
                              ),
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
                            height: 21,
                          ),
                          TextField(
                            controller: passwordController,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.text,
                            cursorColor: AppColors.primaryWhite,
                            style: TextStyle(
                              color:AppColors.primaryWhite
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "パスワード",
                              hintStyle: const TextStyle(
                                color: Color.fromRGBO(112, 112, 112, 1)
                              ),
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
                    const SizedBox(
                      height: 36,
                    ),
                    CustomButton(
                      title: "ログイン",
                      width: 295,
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      color: AppColors.primaryBlue.withOpacity(0.0),
                      borderColor: AppColors.primaryBlue, 
                      titleColor: AppColors.primaryBlue, 
                      onTap: () async{ 
                        Navigator.pushNamed(context, "/findpilot");
                          // final isAuthenticated = Provider.of<UserState>(context, listen: false).isAuthenticated;
                          // if (isAuthenticated) {
                          //   if(Provider.of<UserState>(context, listen: false).user?.isPilot == false){
                          //     await Provider.of<UserState>(context, listen: false).login(emailController.text, passwordController.text);     
                          //   }
                          // }
                      }
                    ),
                  ],
                ),
              ),
            )
          ),

        ],
      )
    );
  }
}
