import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNameScreen extends StatefulWidget {

  const EditNameScreen({super.key});

  @override
  State<EditNameScreen> createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {

  final TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getName();
    nameController.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    nameController.removeListener(_updateButtonColor);
    nameController.dispose();
    super.dispose();
  }

  Future getName() async{
    setState(() {
      nameController.text = Provider.of<UserState>(context, listen: false).user!.name;
    });
  }

  Future saveName() async{
    final isSaved = await Provider.of<UserState>(context, listen: false).saveName(nameController.text);
    if(isSaved){
      await Provider.of<UserState>(context, listen: false).getUserInformation();
      Navigator.pushNamed(context, "/edit_profile");
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
                  "名前変更に失敗しました。",
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
               child: Column(
                 children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 290, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
              height: 94,
              decoration: BoxDecoration(
                color: AppColors.primaryWhite
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      text: "ニックネーム変更", 
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
              height: 94,
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Container(
                                width: 93,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryGreen,
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    saveName();
                                  },
                                  child: Center(
                                    child: Text(
                                      "保 存",
                                      style: TextStyle(
                                        color: AppColors.primaryWhite,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
          
        ],
      )
    );
  }
}
