import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/chatting/phrase_card.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/components/message/received_message_card.dart';
import 'package:drone/components/message/send_message_card.dart';
import 'package:drone/models/chat_message.dart';
import 'package:drone/models/chattingtransfer_model.dart';
import 'package:drone/models/phrase_model.dart';
import 'package:drone/models/user.dart';
import 'package:drone/models/user_model.dart';
import 'package:drone/state/block_state.dart';
import 'package:drone/state/user_state.dart';
import 'package:drone/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class ChattingDetailScreen extends StatefulWidget {
  final User user;
  const ChattingDetailScreen({super.key, required this.user});

  @override
  State<ChattingDetailScreen> createState() => _ChattingDetailScreenState();
}

class _ChattingDetailScreenState extends State<ChattingDetailScreen> {
  late UserModel myself;
  final storage = const FlutterSecureStorage();
  late WebSocketChannel channel;
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<ChatMessage> messages = [];
  final TextEditingController messageController = TextEditingController();
  bool connected = true;
  int textCount = 0;
  bool isLoding = false;
  bool displayPhrase = false;
  bool displayAnswer = false;
  late String adviceState;
  String? answer;
  late List<PhraseModel> phrases;
  @override
  void initState() {
    super.initState();
    loadChatHistory();
    connectWebSocket();
    loadPhraseAndAdviceState();
    messageController.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    messageController.removeListener(_updateButtonColor);
    messageController.dispose();
    channel.sink.close();
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

  Future loadPhraseAndAdviceState() async{
    await Provider.of<UserState>(context, listen: false).getUserInformation();
    await Provider.of<UserState>(context, listen: false).getPhrase();
    await Provider.of<UserState>(context, listen: false).getAdviceState(widget.user.id);
    setState(() {
      phrases = Provider.of<UserState>(context, listen: false).phrase;
      myself = Provider.of<UserState>(context, listen: false).user!;
      if(Provider.of<UserState>(context, listen: false).adviceState != null){
        adviceState = Provider.of<UserState>(context, listen: false).adviceState!.state;
        answer =  Provider.of<UserState>(context, listen: false).adviceState!.answer;
      } else{
        adviceState = 'none';
      }
      isLoding = true;
    });
  }

  Future sendAdviceRequest() async{
    final result = await Provider.of<UserState>(context, listen: false).sendAdviceRequest(widget.user.id);
    if (result) {
      Navigator.pop(context);
      setState(() {
        adviceState = "request";
      });
    }
  }

  Future connectWebSocket() async{
    String? userId = await storage.read(key: 'userId');
    channel = WebSocketChannel.connect(Uri.parse('ws://10.0.2.2:8080/$userId'));
      channel.stream.listen((message) {
        final messageData = jsonDecode(message);
        final ChatMessage newMessage = ChatMessage(
          id: messages.length + 1,
          userId: widget.user.id,
          text: messageData['text'] ?? '',
          imagePath: messageData['imagePath'],
          isSentByMe: false,
          timestamp: DateTime.parse(messageData['timestamp']),
        );
        setState(() {
          messages.add(newMessage);
        });
      },
    );
  }
  
  Future<void> loadChatHistory() async {
    List<Map<String, dynamic>> loadedMessages = await _dbHelper.getMessages(widget.user.id);
    setState(() {
      if (loadedMessages.isNotEmpty) {
        messages = loadedMessages.map((json) => ChatMessage.fromJson(json)).toList();
      }
    });
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

  Future<void> _sendMessage({String? text, String? imagePath}) async {
    if (text == null && imagePath == null) return;
    if (checkedUser()) {
      ChatMessage newMessage = ChatMessage(
        id: messages.length+1,
        userId: widget.user.id,
        text: text ?? '',
        imagePath: imagePath,
        isSentByMe: true,
        timestamp: DateTime.now(),
      );

      await _dbHelper.insertMessage(newMessage.toJson());
      setState(() {
        messages.add(newMessage);
        messageController.clear();
      });

      // Send the message to the backend
      final messageData = {
        'userId': widget.user.id,
        'text': text,
        'imagePath': imagePath,
        'timestamp': newMessage.timestamp.toIso8601String(),
      };
      channel.sink.add(jsonEncode(messageData));
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
  }

  Future getImageFromGallery() async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File? croppedFile = await cropImage(File(pickedFile.path));
      if (croppedFile != null) {
        final imagePath = await _uploadImage(croppedFile);
        if (imagePath != null && connected) {
          _sendMessage(imagePath: imagePath);
        }
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

  Future<String?> _uploadImage(File image) async {
    final url = Uri.parse('${dotenv.get('BASE_URL')}/api/upload/upload_messageimage');
    final imageUploadRequest = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        image.path,
      ));
    final response = await imageUploadRequest.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = jsonDecode(responseBody);
      return decodedResponse['imagePath'];
    } else {
      print('Image upload failed with status: ${response.statusCode}');
      return null;
    }
  }

  Widget messageList(String avatar){
    return SingleChildScrollView(
      child: Column(
        children: messages.map((message){
          return message.isSentByMe ? SendMessageItem(text:message.text, date: DateFormat('yyyy-MM-dd HH:mm').format(message.timestamp), image: message.imagePath):
                ReceivedMessageItem(
                  text: message.text, 
                  avatar: widget.user.avatar, 
                  date: DateFormat('yyyy-MM-dd HH:mm').format(message.timestamp), 
                  image: message.imagePath,
                  onPressed: () {
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
                  },
                );
        }).toList()
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
            setState(() {
              displayAnswer = true;
            });
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

  Future addBlock() async{
    final result = await Provider.of<BlockState>(context, listen: false).addBlock(widget.user.id);
    if (result) {
      Navigator.pop(context);
      Navigator.pushNamed(context, "/chattinglist");
    }
  }


  moreAlertPage(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as ChattingTransferModel;
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
                          Navigator.pushNamed(context, "/violation_screen", arguments: ChattingTransferModel(widget.user.id, widget.user.name, widget.user.avatar, widget.user.prefectureId, widget.user.age));
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
                        // Navigator.pop(context);
                        // Navigator.pop(context);
                        addBlock();
                        
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
              "${widget.user.name}さんと仲良くなるアドバイスを\nコンシェルジュに依頼しますか？",
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
                  sendAdviceRequest();
                  
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
    return BaseScreen(
      child: isLoding? Stack(
        children: [
          Center(
            child: CustomContainer(
              decoration: BoxDecoration(
                color: AppColors.primaryBackground
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:200, bottom: 100),
                child: messageList(widget.user.avatar)
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
                          text: widget.user.name, 
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
                          onPressed: (){
                            if( messageController.text.trim().isNotEmpty && connected){
                              _sendMessage(text : messageController.text);
                            }
                          },
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
          if(displayAnswer)
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
                              padding: const EdgeInsets.only(left: 16, top: 40, bottom: 22),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 39,
                                    height: 39,
                                    child: Image.asset("assets/images/answer.png", fit: BoxFit.cover),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                    text: "公式サポート", 
                                    fontSize: 13, 
                                    fontWeight: FontWeight.normal, 
                                    lineHeight: 1, 
                                    letterSpacing: -1, 
                                    color: AppColors.primaryBlack
                                  )
                                ],
                              )
                            ),
                            SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15, right: 30),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.primaryGray
                                      ),
                                      child: CustomText(
                                        text: answer!, 
                                        fontSize: 13, 
                                        fontWeight: FontWeight.normal, 
                                        lineHeight: 1.5, 
                                        letterSpacing: -1, 
                                        color: AppColors.primaryBlack
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: (){
                                setState(() {
                                  displayAnswer = false;
                                });
                              }, 
                              child: CustomText(
                                text: "とじる", 
                                fontSize: 15, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: -1, 
                                color: AppColors.secondaryGreen
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
      ):const CustomContainer(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
