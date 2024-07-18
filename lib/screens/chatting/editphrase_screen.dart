import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/requestjop_model.dart';
import 'package:flutter/material.dart';

class EditPhraseScreen extends StatefulWidget {
  const EditPhraseScreen({super.key});

  @override
  State<EditPhraseScreen> createState() => _EditPhraseScreenState();
}

class _EditPhraseScreenState extends State<EditPhraseScreen> {
  final TextEditingController phraseController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PhraseModel;
    phraseController.text = args.text;
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                            controller: phraseController,
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
                  ],
                ),
              ),
            ),
          ),
          
          Center(
            child: CustomContainer(
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryWhite,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.primaryGray,
                    width: 2
                  )
                )
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
                            text: "定型文を編集",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            lineHeight: 1,
                            letterSpacing: 1,
                            color: AppColors.primaryBlack,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: CustomContainer(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(top:40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                    },
                                    child: Center(
                                      child: Text(
                                        "保存",
                                        style: TextStyle(
                                          color: AppColors.primaryWhite,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
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
