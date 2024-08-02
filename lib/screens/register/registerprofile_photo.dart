import 'dart:io';

import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterProfilePhotoScreen extends StatefulWidget {

  const RegisterProfilePhotoScreen({super.key});

  @override
  State<RegisterProfilePhotoScreen> createState() => _RegisterProfilePhotoScreenState();
}

class _RegisterProfilePhotoScreenState extends State<RegisterProfilePhotoScreen> {
  File? image;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getImageFromGallery() async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File? croppedFile = await cropImage(File(pickedFile.path));
      setState(() {
        // ignore: unnecessary_null_comparison
        if (croppedFile != null) {
          image = croppedFile;
        }
      });
    }
  }

  Future saveAvatar1() async{
    final isSaved = await Provider.of<UserState>(context, listen: false).saveAvatar1(image!);
    if (isSaved) {
      Navigator.pushNamed(context, "/registerprofile_fourth");                                 
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
                  "写真登録に失敗しました。",
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

  Future<File?> cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
      ),
      IOSUiSettings(
        title: 'Cropper',
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
      ),
      ],
    );
    if(croppedFile != null){
      return File(croppedFile.path);
    }else{
      return null;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "最後にプロフィール写真を\n１枚登録してみよう。", 
                              fontSize: 24, 
                              fontWeight: FontWeight.bold, 
                              lineHeight: 1.5, 
                              letterSpacing: -1, 
                              color: AppColors.primaryBlack
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "ハッキリとわかる写真を選ぶことで、マッチ率が向上します。\n本人確認の際に照合するため、正しい写真を選んでください。", 
                              fontSize: 12, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1.5, 
                              letterSpacing: -1, 
                              color: AppColors.primaryBlack
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, bottom: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  getImageFromGallery();
                                },
                                child: Container(
                                  width: 148,
                                  height: 148,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: AppColors.primaryWhite,
                                              width: 2
                                            ),
                                            color: AppColors.avatarBackColor
                                          ),
                                          child: image==null? Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Image.asset(
                                              "assets/images/avatar1.png",
                                              fit: BoxFit.cover
                                            ),
                                          ):Center(
                                            child: Container(
                                              width: 140,
                                              height: 140,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Image.file(
                                                image!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        ),
                                      ),
                                      Container(
                                        width: 28,
                                        height: 28,
                                        // margin: const EdgeInsets.only(top: -10),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryGreen,
                                          borderRadius: BorderRadius.circular(50)
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 15,
                                            color: AppColors.primaryWhite,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )                            
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: CustomButton(
                                title: "つぎへ",
                                width: 343,
                                height: 45,
                                fontSize: 17, 
                                fontWeight: FontWeight.normal, 
                                color: image==null?AppColors.secondaryGreen.withOpacity(0.5):AppColors.secondaryGreen, 
                                titleColor: AppColors.primaryWhite, 
                                onTap: (){ 
                                  if(image != null){
                                    saveAvatar1();
                                  }
                                }
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

