import 'dart:io';

import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/chatting/phrase_card.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/components/message/received_message_card.dart';
import 'package:drone/components/message/send_message_card.dart';
import 'package:drone/models/chattingtransfer_model.dart';
import 'package:drone/models/requestjop_model.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ChattingDetailScreen extends StatefulWidget {
  const ChattingDetailScreen({super.key});

  @override
  State<ChattingDetailScreen> createState() => _ChattingDetailScreenState();
}

class _ChattingDetailScreenState extends State<ChattingDetailScreen> {
  final TextEditingController messageController = TextEditingController();
  int textCount = 0;
  bool displayPhrase = false;
  String adviceState = "none";
  List<Widget> messages = [ 
    const ReceivedMessageItem(text: "こんにちは、話したいです", avatar: "avatar1.png", date: "2024-02-26 03:58:48"),
    const SendMessageItem(text: '初めまして。\n私は東京都に在住する40歳の太郎です。\nお互いまずはゆっくりとメッセージを重ねて仲良くなりたいです。\nよろしくお願いいたします。', date: "2024-02-26 03:58:48")
  ];
  List<PhraseModel> phrases = [
    PhraseModel(1, "こんにちは！\n共通する趣味や性格に惹かれて、メッセージを送ってみました。\n私はuniqueADREESに在住するuniqueAGE歳のuniqueNAMEです。\nメッセージお待ちしております。" ),
    PhraseModel(2, "初めまして。\n私はuniqueADREESに在住するuniqueAGE歳のuniqueNAMEです。\nお互いまずはゆっくりとメッセージを重ねて仲良くなりたいです。\nよろしくお願いいたします。" ),
    PhraseModel(3, "初めまして。uniqueNAMEと申します。\nプロフィールを拝見して、ぜひ一度メッセージをしたいと思いご連絡いたしました。\nよろしくお願いいたします。" ),
  ];
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
      textCount = messageController.text.length;
    });
  }

  void selectPhrase(String text) {
    setState(() {
      messageController.text = text;
      displayPhrase = false;
    });
  }

  Future getImageFromGallery() async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File? croppedFile = await cropImage(File(pickedFile.path));
      setState(() {
        // ignore: unnecessary_null_comparison
        if (croppedFile != null) {
          DateTime now = DateTime.now();
          messages.add(SendMessageItem(image: croppedFile, date: DateFormat('yyyy-MM-dd HH:mm:ss').format(now)));
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

  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        DateTime now = DateTime.now();
        messages.add(SendMessageItem(text: messageController.text, date: DateFormat('yyyy-MM-dd HH:mm:ss').format(now)));
        messageController.clear();
      });
    }
  }

  Widget messageList(String avatar){
    // setState(() {
    //   messages = [ 
    //     ReceivedMessageItem(text: "こんにちは、話したいです", avatar: avatar, date: "2024-02-26 03:58:48"),
    //     const SendMessageItem(text: '初めまして。\n私は東京都に在住する40歳の太郎です。\nお互いまずはゆっくりとメッセージを重ねて仲良くなりたいです。\nよろしくお願いいたします。', date: "2024-02-26 03:58:48")
    //   ];  
    // });
    return SingleChildScrollView(
      child: Column(
        children: messages
      ),
    );
  }

  Widget adviceButton(){
    if(adviceState == "request") {
      return Container(
        width: 277,
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.secondaryRed.withOpacity(0.5),
              AppColors.secondaryRed,
            ],
          ),
        ),
        child: MaterialButton(
          onPressed: () {
          },
          child: Center(
            child: CustomText(
                text: "回答分析中", 
                fontSize: 13, 
                fontWeight: FontWeight.normal, 
                lineHeight: 1, 
                letterSpacing: -1, 
                color: AppColors.primaryWhite
              ),
          ),
        ),
      );
    } else if(adviceState == "complete"){
      return Container(
        width: 277,
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.secondaryRed
        ),
        child: MaterialButton(
          onPressed: () {
          },
          child: Center(
            child: CustomText(
                text: "アドバイスが用意できました", 
                fontSize: 13, 
                fontWeight: FontWeight.normal, 
                lineHeight: 1, 
                letterSpacing: -1, 
                color: AppColors.primaryWhite
              ),
          ),
        ),
      );
    } else {
      return Container(
        width: 277,
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.secondaryGreen,
            width: 2
          )
        ),
        child: MaterialButton(
          onPressed: () {
            setAdviceAlert(context);
          },
          child: Center(
            child: CustomText(
                text: "この会員と仲良くなるアドバイスを求める", 
                fontSize: 13, 
                fontWeight: FontWeight.normal, 
                lineHeight: 1, 
                letterSpacing: -1, 
                color: AppColors.secondaryGreen
              ),
          ),
        ),
      );
    }
  }

  moreAlertPage(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ChattingTransferModel;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.primaryGray
                          )
                        )
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, "/violation_screen", arguments: ChattingTransferModel(args.id, args.name, args.avatar, args.prefectureId, args.age));
                        },
                        child: Center(
                          child: CustomText(
                            text: "違反報告する", 
                            fontSize: 15, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1, 
                            letterSpacing: -1, 
                            color: AppColors.alertBlue
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setBlockAlert(context);
                        },
                        child: Center(
                          child: CustomText(
                            text: "ブロックする", 
                            fontSize: 15, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1, 
                            letterSpacing: -1, 
                            color: AppColors.secondaryRed
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: CustomText(
                            text: "キャンセル", 
                            fontSize: 15, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1, 
                            letterSpacing: -1, 
                            color: AppColors.alertBlue
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
        )
    );
  }

  setBlockAlert(BuildContext context){
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => Center( // Aligns the container to center
      child: Container( // A simplified version of dialog. 
        width: 320,
        height: 177,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.primaryWhite
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:43, bottom: 33),
              child: Center(
                child: Text(
                  "ブロックをしても\nよろしいですか？",
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontWeight: FontWeight.normal,
                    fontSize:16,
                    decoration: TextDecoration.none
                  ),
                ),
              )
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                      border:Border(
                        top: BorderSide(
                          color: AppColors.primaryGray,
                          width: 1.5
                        ),
                        right: BorderSide(
                          color: AppColors.primaryGray,
                          width: 1.5
                        )
                      )
                    ),
                    child: TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        'キャンセル',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:AppColors.alertBlue,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                  ),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                      border:Border(
                        top: BorderSide(
                          color: AppColors.primaryGray,
                          width: 1.5
                        )
                      )
                    ),
                    child: TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:AppColors.alertBlue,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        )
      )
  );
}

setAdviceAlert(BuildContext context){
  final args = ModalRoute.of(context)!.settings.arguments as ChattingTransferModel;
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
              "${args.name}さんと仲良くなるアドバイスを\nコンシェルジュに依頼しますか？",
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
                  setAdviceConfirmAlert(context);
                },
                child: Center(
                  child: CustomText(
                    text: "無料で依頼", 
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
                    text: "やめる", 
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

setAdviceConfirmAlert(BuildContext context){
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
              "依頼が完了しました\n通常2〜3日で回答が届きます\nトーク画面上部より確認いただけます",
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
              height: 33,
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
                  setState(() {
                    adviceState = "request";
                  });
                },
                child: Center(
                  child: CustomText(
                    text: "とじる", 
                    fontSize: 13, 
                    fontWeight: FontWeight.normal, 
                    lineHeight: 1, 
                    letterSpacing: -1, 
                    color: AppColors.primaryWhite
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
    // final bottomInset = MediaQuery.of(context).viewInsets.bottom;
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
                padding: const EdgeInsets.only(top:200, bottom: 100),
                child: messageList(args.avatar)
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
                          text: args.name, 
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
                CustomContainer(
                  height: 62,
                  decoration: BoxDecoration(
                    color: AppColors.primaryWhite
                  ),
                  child: Center(
                    child: adviceButton()
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    IconButton(
                      onPressed: (){
                        setState(() {
                          moreAlertPage(context);
                        });
                      }, 
                      icon: Icon(
                        Icons.more_horiz,
                        color: AppColors.primaryWhite,
                        size: 30,
                      )
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
                    padding: const EdgeInsets.only(bottom: 108),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 10),
                      height: 42,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 116,
                            height: 42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: AppColors.secondaryGreen,
                                width: 2
                              )
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  displayPhrase = true;
                                });
                              },
                              child: Center(
                                child: CustomText(
                                  text: "定型文を使う", 
                                  fontSize: 11, 
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
                    ),
                  )
                ],
              ),
            ),
          ),
          Center(
            child: CustomContainer(
              // height: MediaQuery.of(context).size.height-(bottomInset),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite,
                      border: Border(
                        top: BorderSide(
                          color: AppColors.secondaryGray.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            getImageFromGallery();
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/photo_icon.png"),
                                fit: BoxFit.cover     
                              )
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 268,
                          height: 80,
                          child: TextField(
                            controller: messageController,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            cursorColor: AppColors.primaryBlack,
                            style: TextStyle(
                              color: AppColors.primaryBlack,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondaryGray.withOpacity(0.5),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondaryGray.withOpacity(0.5),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        IconButton(
                          onPressed: _sendMessage,
                          icon: Icon(
                            Icons.send,
                            color: AppColors.secondaryGreen,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(displayPhrase)
            Center(
              child: CustomContainer(
                child: Padding(
                  padding: const EdgeInsets.only(top:60),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height-60,
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                      )
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 84.5),
                              child: Center(
                                child: CustomText(
                                  text: "定型文を選択", 
                                  fontSize: 13, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.primaryBlack
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: phrases.map((phrase){
                                  return PhraseItem(
                                    id: phrase.id, 
                                    text: phrase.text, 
                                    editPress: (){
                                      selectPhrase(phrase.text);
                                    }
                                  );
                                }).toList()
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: (){
                                setState(() {
                                  displayPhrase = false;
                                });
                              }, 
                              icon: Icon(
                                Icons.close,
                                color: AppColors.primaryBlack,
                                size: 40,
                              )
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ),
              ),
            ),
        ],
      ),
    );
  }
}
