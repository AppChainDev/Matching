import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_button.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/models/chattingtransfer_model.dart';
import 'package:rinlin/models/user_model.dart';
import 'package:rinlin/state/like_state.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:rinlin/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class SwipeMessageScreen extends StatefulWidget {
  const SwipeMessageScreen({super.key});

  @override
  State<SwipeMessageScreen> createState() => _SwipeMessageScreenState();
}

class _SwipeMessageScreenState extends State<SwipeMessageScreen> {
  late UserModel myself;
  final TextEditingController messageController = TextEditingController();
  int messageLength = 0;
  @override
  void initState() {
    super.initState();
    getMySelf();
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

  Future getMySelf() async{
    await Provider.of<UserState>(context, listen: false).getUserInformation();
    setState(() {
      myself = Provider.of<UserState>(context, listen: false).user!;
    });
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

  Future sendMessageLike(int id) async{
    final result = await Provider.of<LikeState>(context, listen: false).sendMessageLike(id, messageController.text);
    if (result) {
      Navigator.pushNamed(context, "/swipe");
    } else {
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
                  "いいねを送信できませんでした。",
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
                                            image: NetworkImage("${dotenv.get('BASE_URL')}/img/${args.avatar}"),
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
                                      if(messageController.text != ""){
                                        if(checkedUser()){
                                          sendMessageLike(args.id);
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
