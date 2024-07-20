import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/image_model.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {

  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController descriptionController = TextEditingController();
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
    final args = ModalRoute.of(context)!.settings.arguments as ImageModel;
    return BaseScreen(
      child: Stack(
        children: [
          Center(
            child: CustomContainer(
              decoration: BoxDecoration(
                color: AppColors.primaryWhite
              ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 123),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if(args.image != null)
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 267,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(
                                  args.image,
                                  scale: 1.0
                                ),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                        const SizedBox(
                          height: 17,
                        ),
                        Container(
                          height: 200,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: SingleChildScrollView(
                            child: TextField(
                              controller: descriptionController,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              cursorColor: AppColors.primaryBlack,
                              style: TextStyle(color: AppColors.primaryBlack),
                              decoration: InputDecoration(
                                hintText: "写真に対してコメントをしてみよう(45字まで)\n個人情報を特定できる内容を記入することはできません",
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                  letterSpacing: -1
                                ),
                                hintMaxLines: 3,
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
                        )
                      ],
                    ),
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
                    padding: const EdgeInsets.only(bottom: 22),
                    child: CustomButton(
                      title: "この内容で投稿",
                      width: 343,
                      height: 45,
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      color: AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () async{ 
                        
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
                      text: "作成画面", 
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
                        Icons.close,
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