import 'dart:io';

import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_button.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/models/image_model.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class VerifySendScreen extends StatefulWidget {

  const VerifySendScreen({super.key});

  @override
  State<VerifySendScreen> createState() => _VerifySendScreenState();
}

class _VerifySendScreenState extends State<VerifySendScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future sendVerifyCard(File image, String verifyType) async{
    final result = await Provider.of<UserState>(context, listen: false).sendVerifyCard(image, verifyType);
    if (result) {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'verifyState', value: "pending");
      Navigator.pushNamed(context, "/verify_waiting");
    }
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 133, left: 47, right: 47),
                    child: Column(
                      children: [
                        if(args.image != null)
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 162,
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 65,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: CustomButton(
                      title: "提出",
                      width: 343,
                      height: 45,
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      color: AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () { 
                        sendVerifyCard(args.image, args.verifyType);
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: CustomButton(
                      title: "撮り直す",
                      width: 343,
                      height: 45,
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      color: AppColors.primaryWhite, 
                      titleColor: AppColors.secondaryGreen, 
                      onTap: () { 
                        Navigator.pop(context);
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
                      text: "本人確認", 
                      fontSize: 17, 
                      fontWeight: FontWeight.bold, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color:AppColors.primaryWhite
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CustomContainer(
                height: 94,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
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
