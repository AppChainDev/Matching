import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/chattingtransfer_model.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';

class SwipeMessageScreen extends StatefulWidget {
  const SwipeMessageScreen({super.key});

  @override
  State<SwipeMessageScreen> createState() => _SwipeMessageScreenState();
}

class _SwipeMessageScreenState extends State<SwipeMessageScreen> {
  final TextEditingController messageController = TextEditingController();
  int messageLength = 0;
  @override
  void initState() {
    super.initState();
    messageController.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    messageController.removeListener(_updateButtonColor);
    messageController.dispose();
    super.dispose();
  }
  
  void _updateButtonColor() {
    setState(() {
      messageLength = messageController.text.length;
    });
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
                color: AppColors.primaryBlack.withOpacity(0.5)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height-60,
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 18),
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                            )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: CustomText(
                                  text: "お相手が喜ぶメッセージを送ろう！", 
                                  fontSize: 13, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.primaryBlack
                                ),
                              ),
                              const SizedBox(
                                height: 26,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 46,
                                        height: 46,
                                        margin: const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          image: DecorationImage(
                                            image: AssetImage("assets/images/${args.avatar}"),
                                            fit: BoxFit.cover
                                          )
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            text: args.name, 
                                            fontSize: 10, 
                                            fontWeight: FontWeight.normal, 
                                            lineHeight: 1.5, 
                                            letterSpacing: 1, 
                                            color: AppColors.primaryBlack
                                          ),
                                          CustomText(
                                            text: "${args.age}歳 ${ConstFile.prefectureItems[args.prefectureId]}", 
                                            fontSize: 8, 
                                            fontWeight: FontWeight.normal, 
                                            lineHeight: 1, 
                                            letterSpacing: 1, 
                                            color: AppColors.primaryBlack
                                          )
                                        ],
                                      )
                                    ],  
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 17,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: TextField(
                                    controller: messageController,
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
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: CustomButton(
                                    title: "特別ないいねを送信", 
                                    width: 343, 
                                    fontSize: 17, 
                                    fontWeight: FontWeight.normal, 
                                    color: messageLength == 0? AppColors.secondaryGray.withOpacity(0.5):AppColors.secondaryRed, 
                                    titleColor: AppColors.primaryWhite, 
                                    onTap: (){
                                      
                                    }
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          }, 
                          icon: Icon(
                            Icons.close,
                            color: AppColors.primaryBlack,
                            size: 30,
                          )
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
