import 'dart:io';

import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class VerifyScreen extends StatefulWidget {

  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String verifyType = "";
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
          Navigator.pushNamed(context, "/verify_send", arguments: ImageModel(croppedFile));
        }
      });
    }
  }

  Future getImageFromCamera() async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File? croppedFile = await cropImage(File(pickedFile.path));
      setState(() {
        // ignore: unnecessary_null_comparison
        if (croppedFile != null) {
          Navigator.pushNamed(context, "/verify_send", arguments: ImageModel(croppedFile));
        }
      });
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

  void selectverifyType() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
            decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
            ),
            height: MediaQuery.of(context).copyWith().size.height*0.4,
            child: Container(
              padding: const EdgeInsets.only(top: 25),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 135,
                    height: 5,
                    color: AppColors.primaryBlack,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CustomText(
                    text: "提出する書類を選択してください", 
                    fontSize: 13, 
                    fontWeight: FontWeight.normal, 
                    lineHeight: 1, 
                    letterSpacing: 1, 
                    color: AppColors.primaryBlack
                  ),
                  const SizedBox(
                    height: 53,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              verifyType = "diverLicense";
                            });
                            Navigator.pop(context);
                            selectImageType();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            margin: const EdgeInsets.only(bottom: 22),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryGreen,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 65,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: const DecorationImage(
                                          image: AssetImage("assets/images/driver_licence1.png"),
                                          fit: BoxFit.cover     
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: CustomText(
                                      text: "運転免許証", 
                                      fontSize: 17, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1, 
                                      letterSpacing: -1, 
                                      color: AppColors.primaryWhite
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              verifyType = "idCard";
                            });
                            Navigator.pop(context);
                            selectImageType();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            margin: const EdgeInsets.only(bottom: 22),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryGreen,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 65,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: const DecorationImage(
                                          image: AssetImage("assets/images/id_number.png"),
                                          fit: BoxFit.cover     
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: CustomText(
                                      text: "マイナンバーカード", 
                                      fontSize: 17, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1, 
                                      letterSpacing: -1, 
                                      color: AppColors.primaryWhite
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
        );
      });
  }

  void selectImageType() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
            decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
            ),
            height: 126,
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImageFromCamera();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo_camera,
                          color: AppColors.primaryBlack,
                          size: 30,
                        ),
                        const SizedBox(width: 30),
                        CustomText(
                          text: "写真を撮る", 
                          fontSize: 15, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: 1, 
                          color: AppColors.primaryBlack
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImageFromGallery();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo_library,
                          color: AppColors.primaryBlack,
                          size: 30,
                        ),
                        const SizedBox(width: 30),
                        CustomText(
                          text: "ライブラリから選ぶ", 
                          fontSize: 15, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: 1, 
                          color: AppColors.primaryBlack
                        )
                      ],
                    ),
                  )
                  
                ],
              ),
            )
        );
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 115, left: 37, right: 37),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryGreen,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "お相手とメッセージをするためには", 
                              fontSize: 12, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 2, 
                              letterSpacing: -1, 
                              color: AppColors.primaryWhite
                            ),
                            CustomText(
                              text: "本人確認が必要です", 
                              fontSize: 25, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1, 
                              letterSpacing: -1, 
                              color: AppColors.primaryWhite
                            ),
                            Container(
                              width: 108,
                              height: 68,
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/driver_licence1.png"),
                                  fit: BoxFit.cover     
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 30),
                      child: Text(
                        "メッセージ機能を利用するには、法律に基づき、公的証明書による\n40歳以上の年齢確認が必要となります。",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryBlack,
                          fontSize: 10,
                          letterSpacing: -0.5,
                          height: 1.5,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 196,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.secondaryGreen,
                            width: 2
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "以下のような身分証は認証されません", 
                              fontSize: 13, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1, 
                              letterSpacing: -0.5, 
                              color: AppColors.primaryBlack
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 93,
                                      height: 60,
                                      margin: const EdgeInsets.only(bottom: 3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: AppColors.primaryGray
                                        ),
                                        image: const DecorationImage(
                                          image: AssetImage("assets/images/driver_licence2.png"),
                                          fit: BoxFit.cover     
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "不透明で\n読み取れない",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.primaryBlack,
                                        fontSize: 9,
                                        letterSpacing: -0.5,
                                        height: 1.5,
                                        fontWeight: FontWeight.normal
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 93,
                                      height: 60,
                                      margin: const EdgeInsets.only(bottom: 3),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/images/driver_licence3.png"),
                                          fit: BoxFit.cover     
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "画像が\n見切れている",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.primaryBlack,
                                        fontSize: 9,
                                        letterSpacing: -0.5,
                                        height: 1.5,
                                        fontWeight: FontWeight.normal
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 93,
                                      height: 60,
                                      margin: const EdgeInsets.only(bottom: 3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: AppColors.primaryGray
                                        ),
                                        image: const DecorationImage(
                                          image: AssetImage("assets/images/driver_licence4.png"),
                                          fit: BoxFit.cover     
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "隠されている\n部分がある",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.primaryBlack,
                                        fontSize: 9,
                                        letterSpacing: -0.5,
                                        height: 1.5,
                                        fontWeight: FontWeight.normal
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Center(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(top: 12),
                              padding: const EdgeInsets.only(top: 32, bottom: 40, left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: AppColors.primaryBackground,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomText(
                                text: "お客様情報は厳重に管理しております。\nご提出いただいた証明書の画像は年齢確認にのみ使用し、それ以外の目的で使用しません。\nお預かりした情報は一定期間保管させていただいたのちに削除しております。", 
                                fontSize: 13, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1.5, 
                                letterSpacing: -1, 
                                color: AppColors.primaryBlack
                              ),
                            ),
                            Image.asset("assets/images/key.png", fit: BoxFit.contain)
                          ],
                        ),
                      ),
                    )
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
                    padding: const EdgeInsets.only(bottom: 22),
                    child: CustomButton(
                      title: "退会する",
                      width: 343,
                      height: 45,
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      color: AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () { 
                        selectverifyType(); 
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
