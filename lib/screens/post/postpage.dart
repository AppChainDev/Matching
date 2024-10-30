import 'dart:async';
import 'dart:io';

import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_button.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/components/post/post_card.dart';
import 'package:rinlin/models/image_model.dart';
import 'package:rinlin/models/user_model.dart';
import 'package:rinlin/models/usertransfer_model.dart';
import 'package:rinlin/models/post_model.dart';
import 'package:rinlin/state/post_state.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:rinlin/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {

  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late UserModel myself;
  final TextEditingController messageController = TextEditingController();
  int messageLength = 0;
  late List<PostModel> posts;
  bool isLoding = false;
  late File? image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getPosts();
    messageController.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    messageController.removeListener(_updateButtonColor);
    messageController.dispose();
    super.dispose();
  }

  bool checkedUser() {
    if (myself.gender == 1) {
      if (myself.isPay && myself.isVerify || myself.experience) {
        return true;
      } else {
        return false;
      }
    } else {
      if (myself.isVerify || myself.experience) {
        return true;
      } else {
        return false;
      }
    }
  }

  void _updateButtonColor() {
    setState(() {
      messageLength = messageController.text.length;
    });
  }

  Future sendPostMessage(int id) async{
    try {
      setState(() {
        posts.removeWhere((post)=>post.id==id);
      });
      Navigator.pop(context);
      await Provider.of<PostState>(context, listen: false).sendPostMessage(id, messageController.text);
    } catch (e) {
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
                    "メッセージの送信に失敗しました。",
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

  Future getPosts() async{
    await Provider.of<PostState>(context, listen: false).getPosts();
    setState(() {
      posts = Provider.of<PostState>(context, listen: false).posts;
      myself = Provider.of<UserState>(context, listen: false).user!;
      isLoding = true;
    });
  }

  Future moveProfile() async{
    const storage = FlutterSecureStorage();
    String? gender =  await storage.read(key: 'gender');
    if (gender != null) {
      // ignore: unrelated_type_equality_checks
      if (int.parse(gender) == 1) {
        Navigator.pushNamed(context, "/malemypage");
      } else {
        Navigator.pushNamed(context, "/femalemypage");
      }
    }
  }

  Future getImageFromCamera() async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File? croppedFile = await cropImage(File(pickedFile.path));
      if (croppedFile != null) {
         Navigator.pushNamed(context, "/create_post", arguments: ImageModel('', croppedFile));
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
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                image: NetworkImage("${dotenv.get('BASE_URL')}/img/$avatar"),
                                fit: BoxFit.cover
                              )
                            )
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
                        onTap: (){
                          if(messageController.text != null && messageController.text != ""){
                            if (checkedUser()) {
                              sendPostMessage(id);
                            } else {
                              if (myself.gender == 1) {
                                if (!myself.isPay) {
                                  planAlert(context);
                                } else if(!myself.isVerify){
                                  verifyAlert(context);
                                }
                              }
                              if (myself.gender == 2) {
                                if (!myself.isVerify) {
                                  verifyAlert(context);
                                } 
                              }
                            }
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
                                        "内容を入力してください。",
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
                          Navigator.pushNamed(context, "/swipe");
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
                          moveProfile();
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

planAlert(BuildContext context){
  showDialog(
    context: context,
    builder: (_) => Center( // Aligns the container to center
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, "/planscreen");
        },
        child: Container( // A simplified version of dialog. 
          width: 316,
          height: 426,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage("assets/images/sale_card1.png"),
              fit: BoxFit.cover
            )
          )
        ),
      )
    )
  );
}

verifyAlert(BuildContext context){
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => Center( // Aligns the container to center
      child: Container( // A simplified version of dialog. 
        width: 270,
        height: 200,
        padding: const EdgeInsets.only(top:35),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryWhite
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "メッセージのやりとりには\n年齢確認が必要です",
              textAlign:TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontWeight: FontWeight.normal,
                fontSize:13,
                letterSpacing: -1,
                decoration: TextDecoration.none
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              width: 245,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.secondaryGreen,
                borderRadius: BorderRadius.circular(50)
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/verifyscreen");
                },
                child: Center(
                  child: CustomText(
                    text: "年齢確認をする", 
                    fontSize: 13, 
                    fontWeight: FontWeight.normal, 
                    lineHeight: 1, 
                    letterSpacing: -1, 
                    color: AppColors.primaryWhite
                  ),
                ),
              ),
            ),
            Container(
              width: 245,
              height: 42,
              margin: const EdgeInsets.only(top: 5),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: CustomText(
                    text: "あとでする", 
                    fontSize: 13, 
                    fontWeight: FontWeight.normal, 
                    lineHeight: 1, 
                    letterSpacing: -1, 
                    color: AppColors.secondaryGreen
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

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async{
        const storage = FlutterSecureStorage();
        String? gender =  await storage.read(key: 'gender');
        if (gender != null) {
          if (int.parse(gender) == 1) {
            Navigator.pushNamed(context, "/malemypage");
          } else {
            Navigator.pushNamed(context, "/femalemypage");
          }
        }
        return true;
      },
      child: BaseScreen(
        child: isLoding? Stack(
          children: [
            if(posts.isNotEmpty)
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
                                    Navigator.pushNamed(context, "/view_profile", arguments: UserTransforIdModel(item.id, id: item.userId, beforePage: 'postpage'));
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
            if(posts.isEmpty)
              Center(
                child: CustomContainer(
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackground
                  ),
                  child: Center(
                    child: CustomText(
                      text: "投稿した共感はありません", 
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color: AppColors.secondaryGreen
                    ),
                  )
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
        ): const CustomContainer(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ),
    );
  }
}
