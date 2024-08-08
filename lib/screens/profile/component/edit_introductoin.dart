import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditIntroduceScreen extends StatefulWidget {
  const EditIntroduceScreen({super.key});

  @override
  State<EditIntroduceScreen> createState() => _EditIntroduceScreenState();
}

class _EditIntroduceScreenState extends State<EditIntroduceScreen> {
  final TextEditingController introduceController = TextEditingController();
  int textCount = 0;

  @override
  void initState() {
    super.initState();
    getIntroduce();
    introduceController.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    introduceController.removeListener(_updateButtonColor);
    introduceController.dispose();
    super.dispose();
  }

  void _updateButtonColor() {
    setState(() {
      textCount = introduceController.text.length;
    });
  }

  Future getIntroduce() async{
    setState(() {
      introduceController.text = Provider.of<UserState>(context, listen: false).user!.introduce;
      textCount = introduceController.text.length;
    });
  }

  Future saveIntroduce() async{
    if (textCount < 150) {
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
                  "150文字以上の\n自己紹介文を書いてください。",
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
    }else{
      final isSaved = await Provider.of<UserState>(context, listen: false).saveIntroduce(introduceController.text);
      if(isSaved){
        await Provider.of<UserState>(context, listen: false).getUserInformation();
        Navigator.pushNamed(context, "/edit_profile");
      }else{
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
                    "自己紹介文の保存に失敗しました。",
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
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    // ignore: deprecated_member_use
    return BaseScreen(
      child: Stack(
        children: [
          Center(
            child: CustomContainer(
              decoration: BoxDecoration(
                color: AppColors.primaryWhite,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 122),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhite,
                      ),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: introduceController,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            cursorColor: AppColors.primaryBlack,
                            style: TextStyle(color: AppColors.primaryBlack),
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
                              fillColor: AppColors.primaryWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: bottomInset),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 20,
                        bottom: bottomInset!=0?bottomInset+10:20
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                            text: "$textCount/150文字", 
                            fontSize: 12, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1, 
                            letterSpacing: 1, 
                            color: AppColors.primaryBlack.withOpacity(0.5)
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          Center(
            child: CustomContainer(
              height: 94,
              decoration: BoxDecoration(
                color: AppColors.secondaryGreen,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                            text: "自己紹介入力",
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            lineHeight: 1,
                            letterSpacing: 1,
                            color: AppColors.primaryWhite,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
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
                                  color: AppColors.primaryWhite,
                                )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Container(
                                  width: 93,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryWhite,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      saveIntroduce();
                                    },
                                    child: Center(
                                      child: Text(
                                        "保 存",
                                        style: TextStyle(
                                          color: AppColors.secondaryGreen,
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
