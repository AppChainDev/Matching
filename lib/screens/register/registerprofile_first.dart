import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_button.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterProfileFirstScreen extends StatefulWidget {

  const RegisterProfileFirstScreen({super.key});

  @override
  State<RegisterProfileFirstScreen> createState() => _RegisterProfileFirstScreenState();
}

class _RegisterProfileFirstScreenState extends State<RegisterProfileFirstScreen> {

  final TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameController.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    nameController.removeListener(_updateButtonColor);
    nameController.dispose();
    super.dispose();
  }

  void _updateButtonColor() {
    setState(() {

    });
  }

  Future saveName() async{
    final isSaved = await Provider.of<UserState>(context, listen: false).saveName(nameController.text);
    if(isSaved){
      Navigator.pushNamed(context, "/registerprofile_second");
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
                  "名前の登録に失敗しました。",
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
               child: Column(
                 children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 108, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "あなたのお名前を教えてください。", 
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
                          text: "普段呼ばれる愛称やニックネームでも構いません。", 
                          fontSize: 12, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1.5, 
                          letterSpacing: -1, 
                          color: AppColors.primaryBlack
                        ),
                        const SizedBox(
                          height: 95,
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
                                  backgroundColor: nameController.text.isNotEmpty?AppColors.secondaryGreen:AppColors.secondaryGray,
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
                          TextField(
                            controller: nameController,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.text,
                            cursorColor: AppColors.primaryBlack,
                            style: TextStyle(
                              color:AppColors.primaryBlack
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: const EdgeInsets.only(left: 15, right: 15),
                              fillColor: AppColors.primaryWhite,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.secondaryGreen, width: 2.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.secondaryGreen, width: 2.0),
                              ),
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
                      color: nameController.text.isEmpty?AppColors.secondaryGreen.withOpacity(0.5):AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () async{ 
                        if(nameController.text.isNotEmpty){
                          saveName();
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
