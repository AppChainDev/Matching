import 'dart:io';

import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/components/post/post_card.dart';
import 'package:drone/models/image_model.dart';
import 'package:drone/models/pilotid_model.dart';
import 'package:drone/models/post_model.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PostScreen extends StatefulWidget {

  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final TextEditingController messageController = TextEditingController();
  int messageLength = 0;
  final List<PostModel> posts = [
    PostModel(1, "ゆうじ", "沖縄の海で去年サーフィンをした時の写真です。\n海がとても好きで共感できる方いますか？", 12, 45, "avatar1.png", "post_backimage1.png"),
    PostModel(2, "こうき", "食べ歩き行きたいですね。\n新座とかで。", 14, 60, "avatar1.png", "post_backimage2.png"),
    PostModel(3, "YUUTA", "お花見の時期ですね", 13, 56, "avatar1.png", "post_backimage3.png"),
  ];
  late File? image;
  final picker = ImagePicker();

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

  void saveMessage(int id){
    setState(() {
      posts.removeWhere((post)=>post.id==id);
    });
  }

  Future getImageFromCamera() async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File? croppedFile = await cropImage(File(pickedFile.path));
      if (croppedFile != null) {
         Navigator.pushNamed(context, "/create_post", arguments: ImageModel(croppedFile));
      }
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

  Future<void> sendMessage(int id, String name, String avatar, int age, int prefectureId) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
            decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
            ),
            height: MediaQuery.of(context).size.height,
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 25),
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: CustomText(
                          text: "すぐに通知を受け取るには", 
                          fontSize: 13, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: -1, 
                          color: AppColors.primaryBlack
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Image.asset("assets/images/$avatar", fit:BoxFit.cover),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "ゆうた", 
                                fontSize: 10, 
                                fontWeight: FontWeight.bold, 
                                lineHeight: 1.5, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    text: "$age歳", 
                                    fontSize: 16, 
                                    fontWeight: FontWeight.bold, 
                                    lineHeight: 1.5, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CustomText(
                                    text: ConstFile.prefectureItems[prefectureId], 
                                    fontSize: 10, 
                                    fontWeight: FontWeight.normal, 
                                    lineHeight: 1.5, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Stack(
                            children: [
                              TextField(
                                controller: messageController,
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                cursorColor: AppColors.primaryBlack,
                                style: TextStyle(color: AppColors.primaryBlack),
                                decoration: InputDecoration(
                                  hintText: "共感へのメッセージで、個人を特定できる連絡先(LINEやInstagram）を記載することは禁止されています。\nお相手のプロフィール内容で共感したところや、仲良くなったら一緒にしたいことを入力するとマッチング率が向上します",
                                  hintMaxLines: 7,
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
                      ),
                      CustomButton(
                        title: "送信",
                        width: 343,
                        height: 45,
                        fontSize: 17, 
                        fontWeight: FontWeight.normal, 
                        color: AppColors.secondaryGreen, 
                        titleColor: AppColors.primaryWhite, 
                        onTap: () async{ 
                          Navigator.pop(context);
                          saveMessage(id);
                        }
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                  Container(
                    height: 21,
                    margin: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: ImageIcon(
                            const AssetImage("assets/images/close_button.png"),
                            color: AppColors.primaryBlack
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        );
      });
  }

  Widget bottomBar(){
    return 
      Center(
        child: CustomContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite
                ),
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/postpage");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/agreement.png"),
                              color: AppColors.secondaryGreen
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              '共感',
                              style: TextStyle(
                                color: AppColors.secondaryGreen,
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      child: MaterialButton(
                        onPressed: () {
                          
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/detection.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              '発見',
                              style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/likelist");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/like.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              'いいね',
                              style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/chattinglist");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/message.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              'メッセージ',
                              style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      child: MaterialButton(
                        onPressed: () {
                          
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/profile.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              'マイページ',
                              style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Stack(
        children: [
          Center(
             child: CustomContainer(
              decoration: BoxDecoration(
                color: AppColors.primaryBackground
              ),
               child: SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.only(top: 144, bottom: 100),
                   child: Column(
                     children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: posts.map((item){
                            return PostItem(
                              id: item.id,
                              name: item.name, 
                              prefectureId: item.id, 
                              age: item.age, 
                              description: item.description, 
                              bgImage: item.backImage, 
                              avatarImage: item.avatar, 
                              pressProfile: (){
                                Navigator.pushNamed(context, "/view_profile", arguments: UserTransforIdModel(id: item.id, beforePage: 'postpage'));
                              }, 
                              pressMessage: (){
                                sendMessage(item.id, item.name, item.avatar, item.age, item.prefectureId);
                              }
                            );
                          }).toList(),
                        ),
                      ),
                     ],
                   ),
                 ),
               ),
             ),
           ),
           
           Center(
            child: CustomContainer(
              height: 127,
              decoration: BoxDecoration(
                color: AppColors.primaryWhite
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      title: "投稿を作成", 
                      width: 343, 
                      fontSize: 14, 
                      fontWeight: FontWeight.normal, 
                      color: AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: (){
                        // Navigator.pushNamed(context, "/create_post");
                        getImageFromCamera();
                      }
                    )
                  ],
                ),
              ),
            ),
          ),
          bottomBar()
          
        ],
      )
    );
  }
}
