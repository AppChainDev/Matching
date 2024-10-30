import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_button.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/models/record_model.dart';
import 'package:rinlin/models/user_model.dart';
import 'package:rinlin/state/notification_state.dart';
import 'package:rinlin/state/post_state.dart';
import 'package:rinlin/state/record_state.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:rinlin/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class MaleMyPage extends StatefulWidget {
  const MaleMyPage({super.key});

  @override
  State<MaleMyPage> createState() => _MaleMyPageState();
}

class _MaleMyPageState extends State<MaleMyPage> {
  final storage = const FlutterSecureStorage();
  late UserModel user;
  late List<RecordModel> records;
  int myPostNewMessages = 0;
  int newNotificatons = 0;
  bool isLoding = false;

  @override
  void initState() {
    super.initState();
    getUserInformation();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   notificationAlert();
    // });
    checkAlert();
    getVerifyState();
    getMyPost();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future checkAlert() async {
    String? alert = await storage.read(key: 'alert');
    if (alert == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notificationAlert();
      });
    }
  }

  Future getUserInformation() async {
    await Provider.of<UserState>(context, listen: false).getUserInformation();
    await Provider.of<RecordState>(context, listen: false).getRecord();
    await Provider.of<NotificationState>(context, listen: false)
        .getNotifications();
    setState(() {
      user = Provider.of<UserState>(context, listen: false).user!;
      records = Provider.of<RecordState>(context, listen: false).records;
      Provider.of<NotificationState>(context, listen: false)
          .notifications
          .map((item) {
        if (item.usersArray.contains(user.id) == false) {
          newNotificatons++;
        }
      }).toList();
      isLoding = true;
    });
  }

  Future getVerifyState() async {
    String? verifyState = await storage.read(key: 'verifyState');
    if (verifyState == "pending") {
      final state =
          await Provider.of<UserState>(context, listen: false).getVerifyState();
      if (state != null) {
        if (state == "checked") {
          verifyConfirmAlert(context);
        }
        if (state == "failed") {
          verifyFailedAlert(context);
        }
      }
    }
  }

  Future getMyPost() async {
    await Provider.of<PostState>(context, listen: false).getMyPost();
    setState(() {
      Provider.of<PostState>(context, listen: false).myPosts.map((item) {
        if (item.newNessageCount != null) {
          myPostNewMessages = myPostNewMessages + item.newNessageCount!;
        }
      }).toList();
    });
  }

  Future clickedConfirm(String state) async {
    final result =
        await Provider.of<UserState>(context, listen: false).verifyChecked();
    if (result) {
      await storage.write(key: 'verifyState', value: state);
      if (state == "checked") {
        Navigator.pop(context);
      } else {
        Navigator.pushNamed(context, "/verifyscreen");
      }
    }
  }

  void notificationAlert() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
              decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              height: MediaQuery.of(context).copyWith().size.height * (2 / 3),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 32, left: 26, right: 26, bottom: 15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: "すぐに通知を受け取るには",
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                        lineHeight: 1,
                        letterSpacing: -1,
                        color: AppColors.primaryBlack),
                    Image.asset("assets/images/allow_notification.png",
                        fit: BoxFit.cover),
                    CustomText(
                        text:
                            "アプリの通知を許可することで、他のユーザーからの通知をすぐに確認できスムーズなコミュニケーションを取ることが可能です。",
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        lineHeight: 1.5,
                        letterSpacing: -2,
                        color: AppColors.primaryBlack),
                    Container(
                      width: 316,
                      height: 97,
                      padding: const EdgeInsets.only(top: 10, left: 17),
                      decoration: BoxDecoration(
                          color: AppColors.primaryGray.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: "いいねを受け取った時\nマッチング成立時\n他のユーザーからのメッセージ",
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              lineHeight: 1.5,
                              letterSpacing: -1,
                              color: AppColors.primaryBlack)
                        ],
                      ),
                    ),
                    CustomButton(
                        title: "次へ",
                        width: 343,
                        height: 45,
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: AppColors.secondaryGreen,
                        titleColor: AppColors.primaryWhite,
                        onTap: () async {
                          Navigator.pop(context);
                          allowNotification(context);
                          await storage.write(key: 'alert', value: "true");
                        }),
                  ],
                ),
              ));
        });
  }

  void buyBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
              decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              height: MediaQuery.of(context).copyWith().size.height * 0.4,
              child: Container(
                padding: const EdgeInsets.only(top: 65, left: 13, right: 13),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: "ポイント購入",
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            lineHeight: 1,
                            letterSpacing: 1,
                            color: AppColors.primaryBlack),
                        Container(
                          width: 112,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColors.primaryBackground,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 23,
                                        height: 23,
                                        margin: const EdgeInsets.only(left: 8),
                                        child: Image.asset(
                                            "assets/images/point.png",
                                            fit: BoxFit.cover)),
                                  ],
                                ),
                              ),
                              Center(
                                child: CustomText(
                                    text: "${user.pointCount}",
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    lineHeight: 1,
                                    letterSpacing: -1,
                                    color: AppColors.secondaryGreen),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                            text: "ポイントを購入することで\nお相手にいいねを送ることができます",
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            lineHeight: 1.5,
                            letterSpacing: -1,
                            color: AppColors.primaryBlack)
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/10_point.png"),
                                  fit: BoxFit.cover),
                            ),
                            child: MaterialButton(onPressed: () {})),
                        Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/50_point.png"),
                                  fit: BoxFit.cover),
                            ),
                            child: MaterialButton(onPressed: () {})),
                        Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/100_point.png"),
                                  fit: BoxFit.cover),
                            ),
                            child: MaterialButton(onPressed: () {}))
                      ],
                    )
                  ],
                ),
              ));
        });
  }

  Widget bottomBar() {
    return Center(
      child: CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors.primaryWhite),
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/postpage");
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                              const AssetImage("assets/images/agreement.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)),
                          const SizedBox(
                            height: 9,
                          ),
                          Text(
                            '共感',
                            style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/swipe");
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                              const AssetImage("assets/images/detection.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)),
                          const SizedBox(
                            height: 9,
                          ),
                          Text(
                            '発見',
                            style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/likelist");
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(const AssetImage("assets/images/like.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)),
                          const SizedBox(
                            height: 9,
                          ),
                          Text(
                            'いいね',
                            style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/chattinglist");
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                              const AssetImage("assets/images/message.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)),
                          const SizedBox(
                            height: 9,
                          ),
                          Text(
                            'メッセージ',
                            style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                              const AssetImage("assets/images/profile.png"),
                              color: AppColors.secondaryGreen),
                          const SizedBox(
                            height: 9,
                          ),
                          Text(
                            'マイページ',
                            style: TextStyle(
                                color: AppColors.secondaryGreen,
                                fontSize: 9,
                                fontWeight: FontWeight.normal),
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

  allowNotification(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => Center(
                // Aligns the container to center
                child: Container(
              // A simplified version of dialog.
              width: 270,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                // color: AppColors.primaryWhite.withOpacity(0.9)
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryYellow.withOpacity(0.9),
                    AppColors.primaryYellow.withOpacity(0.7)
                  ],
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Center(
                      child: Text(
                        "通知を送信します\n許可しますか？",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 30),
                      child: Center(
                        child: Text(
                          "通知方法は、テキスト、サウンド、アイコンが\n利用できる可能性を含みます。\n通知方法は「設定」で設定できます。",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.primaryBlack,
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                              decoration: TextDecoration.none),
                        ),
                      )),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 135,
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: AppColors.primaryBlack
                                          .withOpacity(0.4),
                                      width: 1.5),
                                  right: BorderSide(
                                      color: AppColors.primaryBlack
                                          .withOpacity(0.4),
                                      width: 1.5))),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                '許可しない',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.alertBlue,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        Container(
                          width: 135,
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: AppColors.primaryBlack
                                          .withOpacity(0.4),
                                      width: 1.5))),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                '許可',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.alertBlue,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  verifyConfirmAlert(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => Center(
                // Aligns the container to center
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                // A simplified version of dialog.
                width: MediaQuery.of(context).size.width,
                height: 380,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryWhite),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "本人確認が\n認証されました",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.primaryBlack,
                          letterSpacing: 1,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none),
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      margin: const EdgeInsets.only(top: 40, bottom: 63),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/verify_confirm.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryGreen,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          clickedConfirm("checked");
                        },
                        child: Center(
                          child: Text(
                            "とじる",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                letterSpacing: 1,
                                color: AppColors.primaryWhite,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  verifyFailedAlert(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => Center(
                // Aligns the container to center
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                // A simplified version of dialog.
                width: MediaQuery.of(context).size.width,
                height: 628,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryWhite),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 314,
                      decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 92,
                            height: 92,
                            margin: const EdgeInsets.only(bottom: 42),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/warning.png"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Text(
                            "ご提出いただいた公的書類では審査が\n完了できませんでした\n以下の点に注意して再度ご提出お願いいたします",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.primaryBlack,
                                letterSpacing: 1,
                                fontSize: 13,
                                height: 0,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none),
                          ),
                          const SizedBox(
                            height: 37,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 314,
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "以下のような身分証は認証されません",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.primaryBlack,
                                letterSpacing: -0.5,
                                fontSize: 14,
                                height: 0,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none),
                          ),
                          const SizedBox(
                            height: 30,
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
                                          color: AppColors.primaryGray),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/driver_licence2.png"),
                                          fit: BoxFit.cover),
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
                                        fontWeight: FontWeight.normal),
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
                                          image: AssetImage(
                                              "assets/images/driver_licence3.png"),
                                          fit: BoxFit.cover),
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
                                        fontWeight: FontWeight.normal),
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
                                          color: AppColors.primaryGray),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/driver_licence4.png"),
                                          fit: BoxFit.cover),
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
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryGreen,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      clickedConfirm("checked");
                                    },
                                    child: Center(
                                      child: Text(
                                        "再申請する",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 1,
                                            color: AppColors.primaryWhite,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryWhite,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () async {
                                      final result =
                                          await Provider.of<UserState>(context,
                                                  listen: false)
                                              .verifyChecked();
                                      if (result) {
                                        await storage.write(
                                            key: 'verifyState',
                                            value: "failed");
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        "とじる",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 1,
                                            color: AppColors.secondaryGreen,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        child: !isLoding
            ? const CustomContainer(
                child: Center(child: CircularProgressIndicator()))
            : Stack(
                children: [
                  Center(
                    child: CustomContainer(
                      decoration: BoxDecoration(color: AppColors.primaryWhite),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 76, left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 90,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          height: 90,
                                          child: Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 7),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "${dotenv.get('BASE_URL')}/img/${user.avatars[0]}"),
                                                          fit: BoxFit.cover,
                                                        ))),
                                              ),
                                              Container(
                                                width: 28,
                                                height: 28,
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .secondaryGreen,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .primaryWhite,
                                                        width: 2)),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 15,
                                                    color:
                                                        AppColors.primaryWhite,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                    text: user.name,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    lineHeight: 1.5,
                                                    letterSpacing: -1,
                                                    color:
                                                        AppColors.primaryBlack),
                                                Row(
                                                  children: [
                                                    CustomText(
                                                        text: "${user.age}歳",
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        lineHeight: 1,
                                                        letterSpacing: 1,
                                                        color: AppColors
                                                            .primaryBlack),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    CustomText(
                                                        text: ConstFile
                                                                .prefectureItems[
                                                            user.prefectureId],
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        lineHeight: 1,
                                                        letterSpacing: 1,
                                                        color: AppColors
                                                            .primaryBlack),
                                                  ],
                                                )
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, "/edit_profile");
                                              },
                                              child: Container(
                                                width: 221,
                                                height: 42,
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .secondaryGreen
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .secondaryGreen,
                                                        width: 2)),
                                                child: Center(
                                                  child: CustomText(
                                                      text: "プロフィール編集",
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      lineHeight: 1,
                                                      letterSpacing: 1,
                                                      color: AppColors
                                                          .secondaryGreen),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 22,
                                        left: 10,
                                        right: 10,
                                        bottom: 22),
                                    child: SizedBox(
                                      height: 66,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (!user.isVerify) {
                                                Navigator.pushNamed(
                                                    context, "/verifyscreen");
                                              }
                                            },
                                            child: Container(
                                                width: 99,
                                                height: 66,
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .secondaryGreen
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CustomText(
                                                        text: "本人確認",
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        lineHeight: 2,
                                                        letterSpacing: 1,
                                                        color: AppColors
                                                            .primaryBlack),
                                                    CustomText(
                                                        text: user.isVerify
                                                            ? "確認済"
                                                            : "未確認",
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        lineHeight: 1,
                                                        letterSpacing: 1,
                                                        color: AppColors
                                                            .primaryBlack)
                                                  ],
                                                )),
                                          ),
                                          Container(
                                              width: 99,
                                              height: 66,
                                              decoration: BoxDecoration(
                                                  color: AppColors
                                                      .secondaryGreen
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                      text: "ステータス",
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      lineHeight: 2,
                                                      letterSpacing: 1,
                                                      color: AppColors
                                                          .primaryBlack),
                                                  CustomText(
                                                      text: user.isPay
                                                          ? "会員"
                                                          : "無料",
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      lineHeight: 1,
                                                      letterSpacing: 1,
                                                      color: AppColors
                                                          .primaryBlack)
                                                ],
                                              )),
                                          GestureDetector(
                                            onTap: () {
                                              buyBottomSheet();
                                            },
                                            child: Container(
                                                width: 99,
                                                height: 66,
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .secondaryGreen
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CustomText(
                                                        text: "ポイント",
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        lineHeight: 2,
                                                        letterSpacing: 1,
                                                        color: AppColors
                                                            .primaryBlack),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                            "assets/images/p_icon.png",
                                                            fit: BoxFit.cover),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        CustomText(
                                                            text: user
                                                                .pointCount
                                                                .toString(),
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            lineHeight: 1,
                                                            letterSpacing: 1,
                                                            color: AppColors
                                                                .primaryBlack),
                                                      ],
                                                    )
                                                  ],
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (!user.isPay)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/planscreen");
                                        },
                                        child: Container(
                                            height: 350,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/sale_card.png")))),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25, bottom: 23),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 36.5),
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        if (records.isNotEmpty) {
                                          if (user.viewUsers! > 0) {
                                            await Provider.of<UserState>(
                                                    context,
                                                    listen: false)
                                                .clearViewUsers();
                                          }
                                          Navigator.pushNamed(
                                              context, '/record_list');
                                        } else {
                                          Navigator.pushNamed(
                                              context, '/record_empty');
                                        }
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Container(
                                                  width: 50,
                                                  height: 50,
                                                  margin: const EdgeInsets.only(
                                                      top: 10, right: 10),
                                                  child: Image.asset(
                                                    "assets/images/record.png",
                                                    fit: BoxFit.contain,
                                                  )),
                                              if (user.viewUsers! > 0)
                                                Container(
                                                  width: 22,
                                                  height: 22,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.thirdRed,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                    child: CustomText(
                                                        text: user.viewUsers
                                                            .toString(),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        lineHeight: 1,
                                                        letterSpacing: 1,
                                                        color: AppColors
                                                            .primaryWhite),
                                                  ),
                                                )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 9,
                                          ),
                                          Text(
                                            'あしあと',
                                            style: TextStyle(
                                                color: AppColors.primaryBlack
                                                    .withOpacity(0.6),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 36.5),
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, "/agreement");
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Container(
                                                  width: 50,
                                                  height: 50,
                                                  margin: const EdgeInsets.only(
                                                      top: 10, right: 10),
                                                  child: Image.asset(
                                                    "assets/images/bog_agreement.png",
                                                    fit: BoxFit.contain,
                                                  )),
                                              if (myPostNewMessages > 0)
                                                Container(
                                                  width: 22,
                                                  height: 22,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.thirdRed,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                    child: CustomText(
                                                        text: myPostNewMessages
                                                            .toString(),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        lineHeight: 1,
                                                        letterSpacing: 1,
                                                        color: AppColors
                                                            .primaryWhite),
                                                  ),
                                                )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 9,
                                          ),
                                          Text(
                                            '共感',
                                            style: TextStyle(
                                                color: AppColors.primaryBlack
                                                    .withOpacity(0.6),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 36.5),
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, "/support");
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: 50,
                                              height: 50,
                                              margin: const EdgeInsets.only(
                                                  top: 10, right: 10),
                                              child: Image.asset(
                                                "assets/images/consultation.png",
                                                fit: BoxFit.contain,
                                              )),
                                          const SizedBox(
                                            height: 9,
                                          ),
                                          Text(
                                            '相談',
                                            style: TextStyle(
                                                color: AppColors.primaryBlack
                                                    .withOpacity(0.6),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 36.5),
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, "/setting");
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: 50,
                                              height: 50,
                                              margin: const EdgeInsets.only(
                                                  top: 10, right: 10),
                                              child: Image.asset(
                                                "assets/images/setting.png",
                                                fit: BoxFit.contain,
                                              )),
                                          const SizedBox(
                                            height: 9,
                                          ),
                                          Text(
                                            '各種設定',
                                            style: TextStyle(
                                                color: AppColors.primaryBlack
                                                    .withOpacity(0.6),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 36.5),
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: MaterialButton(
                                      onPressed: () {},
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: 50,
                                              height: 50,
                                              margin: const EdgeInsets.only(
                                                  top: 10, right: 10),
                                              child: Image.asset(
                                                "assets/images/help.png",
                                                fit: BoxFit.contain,
                                              )),
                                          const SizedBox(
                                            height: 9,
                                          ),
                                          Text(
                                            'ヘルプ',
                                            style: TextStyle(
                                                color: AppColors.primaryBlack
                                                    .withOpacity(0.6),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 36.5),
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/notification');
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Container(
                                                  width: 50,
                                                  height: 50,
                                                  margin: const EdgeInsets.only(
                                                      top: 10, right: 10),
                                                  child: Image.asset(
                                                    "assets/images/notification.png",
                                                    fit: BoxFit.contain,
                                                  )),
                                              if (newNotificatons > 0)
                                                Container(
                                                  width: 22,
                                                  height: 22,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.thirdRed,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                    child: CustomText(
                                                        text: newNotificatons
                                                            .toString(),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        lineHeight: 1,
                                                        letterSpacing: 1,
                                                        color: AppColors
                                                            .primaryWhite),
                                                  ),
                                                )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 9,
                                          ),
                                          Text(
                                            'お知らせ',
                                            style: TextStyle(
                                                color: AppColors.primaryBlack
                                                    .withOpacity(0.6),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 106,
                              margin: const EdgeInsets.only(bottom: 100),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Container(
                                    width: 204,
                                    height: 87,
                                    margin: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.primaryGray),
                                    child: const Center(
                                      child: Text(
                                        "広告A",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 204,
                                    height: 87,
                                    margin: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.primaryGray),
                                    child: const Center(
                                      child: Text(
                                        "広告8",
                                        style: TextStyle(fontSize: 17),
                                      ),
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
                  bottomBar()
                ],
              ));
  }
}
