
import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:provider/provider.dart';

class MailSendScreen extends StatefulWidget {

  const MailSendScreen({super.key});

  @override
  State<MailSendScreen> createState() => _MailSendScreenState();
}
class _MailSendScreenState extends State<MailSendScreen> {
  final TextEditingController emailController = TextEditingController();

  late bool isregisted;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Stack(
        children: [
           Center(
             child: CustomContainer(
              child: Image.asset(
                "assets/images/black_back.png",
                fit: BoxFit.cover
              ),
             ),
           ),
           Center(
            child: CustomContainer(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(top:30, left:20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        icon: Image.asset("assets/images/back_mark.png", fit: BoxFit.cover,)
                      ),
                    ),
                  ],
                ),
              ),
            ),
           ),
           Center(
             child: Padding(
              padding: const EdgeInsets.only(top: 44),
              child: CustomText(
                text: "ユーザー登録",
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
                padding: const EdgeInsets.only(top: 296),
                 child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
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
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      title: "送 信",
                      width: 295,
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      color: AppColors.primaryWhite.withOpacity(0.0),
                      borderColor: AppColors.primaryGreen, 
                      titleColor: AppColors.primaryGreen, 
                      onTap: () async{
                        // const CustomAlert(text: "Alert");
                        // Navigator.pushNamed(context, "/mailsendalert");   
                        try {
                          isregisted = await Provider.of<UserState>(context, listen: false).register(emailController.text);
                          if(isregisted){
                          // ignore: use_build_context_synchronously
                            Navigator.pushNamed(context, "/mailsendalert");
                          }
                        } catch (e) {
                          print(e);
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
               child: Padding(
                padding: const EdgeInsets.only(bottom: 71),
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     MaterialButton(
                      onPressed: (){
                        Navigator.pushNamed(context, "/login");
                      },
                      child: Text(
                        "既存のアカウントでログイン",
                        style: TextStyle(
                          color: AppColors.primaryWhite,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryWhite
                        ),
                      ),
                    ),
                   ],
                 )
               )
             ),
           ),
        ],
      )
    );
  }
}
