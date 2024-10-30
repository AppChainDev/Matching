import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_button.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/models/chattingtransfer_model.dart';
import 'package:rinlin/state/block_state.dart';
import 'package:rinlin/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
class ViolationScreen extends StatefulWidget {
  const ViolationScreen({super.key});

  @override
  State<ViolationScreen> createState() => _ViolationScreenState();
}

class _ViolationScreenState extends State<ViolationScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future addReport(int id) async{
    final result = await Provider.of<BlockState>(context, listen: false).addReport(id);
    if (result) {
      Navigator.pushNamed(context, "/violationconfirm_screen");
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
                  "すでに申告済みのユーザーです。",
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
    final args = ModalRoute.of(context)!.settings.arguments as ChattingTransferModel;
    return BaseScreen(
      child: Stack(
        children: [
          Center(
            child: CustomContainer(
              decoration: BoxDecoration(
                color: AppColors.primaryBackground
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:150),
                child: Column(
                  children: [
                    CustomText(
                      text: "下記のユーザーを違反報告しますか？", 
                      fontSize: 14, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 1, 
                      letterSpacing: -1, 
                      color: AppColors.primaryBlack
                    ),
                    Container(
                      width: 87,
                      height: 87,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: NetworkImage("${dotenv.get('BASE_URL')}/img/${args.avatar}"),
                          fit: BoxFit.cover,  
                        ) 
                      ),
                    ),
                    CustomText(
                      text: args.name, 
                      fontSize: 16, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 2, 
                      letterSpacing: 1, 
                      color: AppColors.primaryBlack
                    ),
                    CustomText(
                      text: "${ConstFile.prefectureItems[args.prefectureId]} ${args.age}歳", 
                      fontSize: 12, 
                      fontWeight: FontWeight.normal, 
                      lineHeight:   2, 
                      letterSpacing: 1, 
                      color: AppColors.secondaryGray
                    ),
                    const SizedBox(
                      height: 85,
                    ),
                    Text(
                      "報告後に運営サポートにより\n会員調査を行います",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryBlack,
                        height: 1.5
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                CustomContainer(
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
                          text: "違反報告", 
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
              ],
            ),
          ),
          Center(
            child: CustomContainer(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(top:46),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
          Center(
            child: CustomContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 79),
                    child: CustomButton(
                      title: "通報する",
                      width: 343,
                      height: 45,
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      color: AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () {
                        addReport(args.id); 
                      }
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



