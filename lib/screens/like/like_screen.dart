import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/components/like/like_card.dart';
import 'package:rinlin/models/like_model.dart';
import 'package:rinlin/models/matching_model.dart';
import 'package:rinlin/models/usertransfer_model.dart';
import 'package:rinlin/state/like_state.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class LikeListScreen extends StatefulWidget {

  const LikeListScreen({super.key});

  @override
  State<LikeListScreen> createState() => _LikeListScreenState();
}

class _LikeListScreenState extends State<LikeListScreen> {

  late List<LikeModel> likes;
  late int point;
  bool isLoding = false;
  int currenIndex = 0;

  @override
  void initState() {
    getLikeList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getLikeList() async{
    await Provider.of<LikeState>(context, listen: false).getLikeList();
    setState(() {
      likes = Provider.of<LikeState>(context, listen: false).likes;
      point = Provider.of<UserState>(context, listen: false).user!.pointCount;
      isLoding = true;
    });
  }

  Future skipClick(int id) async{
    final result = await Provider.of<LikeState>(context, listen: false).skipLike(id);
    if (result) {
      await Provider.of<UserState>(context, listen: false).getUserInformation(); 
      setState(() {
        point = Provider.of<UserState>(context, listen: false).user!.pointCount;
        likes.removeWhere((item)=>item.id == id);
        if (likes.isEmpty) {
          currenIndex = 0;
        } else {
          currenIndex = (currenIndex >= likes.length) ? likes.length - 1 : currenIndex;
        }
      }); 
    }
  }
  Future thanksClick(int id, String avatar, String name) async{
    final result = await Provider.of<LikeState>(context, listen: false).createMatching(id);
    if (result) {
      await Provider.of<UserState>(context, listen: false).getUserInformation(); 
      setState(() {
        point = Provider.of<UserState>(context, listen: false).user!.pointCount;
        likes.removeWhere((item)=>item.id == id);
        if (likes.isEmpty) {
          currenIndex = 0;
        } else {
          currenIndex = (currenIndex >= likes.length) ? likes.length - 1 : currenIndex;
        }
      });
    }
    Navigator.pushNamed(context, "/likematching_complete", arguments: MatchingModel(id: id, avatar: avatar, name: name));
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
                              color: AppColors.secondaryGray.withOpacity(0.5)
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              '共感',
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
                          
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/like.png"),
                              color: AppColors.secondaryGreen
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              'いいね',
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

  buyPointAlert(BuildContext context){
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => Center( // Aligns the container to center
      child: Container( // A simplified version of dialog. 
        width: 343,
        height: 213,
        padding: const EdgeInsets.only(top:35),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryWhite
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ポイントが不足してます\n追加しますか",
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
                  buyBottomSheet();
                },
                child: Center(
                  child: CustomText(
                    text: "追加する", 
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
                    text: "キャンセル", 
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

void buyBottomSheet() {
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
                        color: AppColors.primaryBlack
                      ),
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
                                    child: Image.asset("assets/images/point.png", fit:BoxFit.cover)
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: CustomText(
                                  text: "$point", 
                                  fontSize: 17, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.secondaryGreen
                                ),
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
                        color: AppColors.primaryBlack
                      )
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
                            image: AssetImage("assets/images/10_point.png"),
                            fit: BoxFit.cover     
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: (){}
                        )
                      ),
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/50_point.png"),
                            fit: BoxFit.cover     
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: (){}
                        )
                      ),
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/100_point.png"),
                            fit: BoxFit.cover     
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: (){}
                        )
                      )
                    ],
                  )
                ],
              ),
            )
        );
      });
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
            if(likes.isNotEmpty)
              Stack(
                children: [
                  Center(
                    child: CustomContainer(
                      decoration: BoxDecoration(
                        color: AppColors.primaryBackground
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(top: 100),
                        child: likes.length>=2? CardSwiper(
                          cardsCount: likes.length,
                          scale: 0.7,
                          isLoop: true,
                          maxAngle: 90,
                          initialIndex: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          allowedSwipeDirection: const AllowedSwipeDirection.only(left: true, right: true),
                          cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                            currenIndex = index-1;
                            if(index >= likes.length) {
                              return LikeItem(
                                id: likes[likes.length-1].id, 
                                name: likes[likes.length-1].name,
                                description: likes[likes.length-1].description, 
                                prefectureId: likes[likes.length-1].prefectureId, 
                                age: likes[likes.length-1].age, 
                                avatars: likes[likes.length-1].avatars, 
                                pressSkip: (){
                                  if(point > 0) {
                                    skipClick(likes[likes.length-1].id);
                                  } else {
                                    buyPointAlert(context);
                                  }
                                },  
                                pressThanks: (){
                                  if (point > 0) {  
                                    thanksClick(likes[likes.length-1].id, likes[likes.length-1].avatars[0], likes[likes.length-1].name);
                                  } else {
                                    buyPointAlert(context);
                                  }
                                },
                                pressProfile: () {
                                  Navigator.pushNamed(context, "/view_profile", arguments: UserTransforIdModel(null ,id: likes[likes.length-1].id, beforePage: 'likepage'));
                                }, 
                                verify: likes[likes.length-1].verify, 
                                favouriteText: likes[likes.length-1].favouriteText,
                                favouriteImage: likes[likes.length-1].favouriteImage,
                              );  
                            }
                            var item = likes[index];
                            if(index != 0){
                              currenIndex = index-1;
                            } else{
                              currenIndex = (likes.length > 1) ? likes.length -1 : 0;
                            }
                            return LikeItem(
                              id: item.id, 
                              name: item.name,
                              description: item.description, 
                              prefectureId: item.prefectureId, 
                              age: item.age, 
                              avatars: item.avatars, 
                              pressSkip: (){
                                if (point > 0) {
                                  skipClick(item.id);   
                                } else {
                                  buyPointAlert(context);
                                }
                              }, 
                              pressThanks: () {
                                if (point > 0) {  
                                  thanksClick(item.id, item.avatars[0], item.name);
                                } else {
                                  buyPointAlert(context);
                                }
                              }, 
                              pressProfile: () {
                                Navigator.pushNamed(context, "/view_profile", arguments: UserTransforIdModel(null, id: item.id, beforePage: 'likepage'));
                              }, 
                              verify: item.verify, 
                              favouriteText: item.favouriteText,
                              favouriteImage: item.favouriteImage,
                            );               
                          }, 
                        )
                        :Column(
                          children: likes.map((item){
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: LikeItem(
                                  id: item.id, 
                                  name: item.name, 
                                  description: item.description,
                                  prefectureId: item.prefectureId, 
                                  age: item.age, 
                                  avatars: item.avatars, 
                                  pressSkip: (){
                                    if (point > 0) {
                                      skipClick(item.id);   
                                    } else {
                                      buyPointAlert(context);
                                    }
                                  },
                                  pressThanks: () {
                                    if (point > 0) {  
                                      thanksClick(item.id, item.avatars[0], item.name);
                                    } else {
                                      buyPointAlert(context);
                                    }
                                  }, 
                                  pressProfile: () {
                                    Navigator.pushNamed(context, "/view_profile", arguments: UserTransforIdModel(null, id: item.id, beforePage: 'likepage'));
                                  }, 
                                  verify: item.verify, 
                                  favouriteText: item.favouriteText,
                                  favouriteImage: item.favouriteImage,
                                ),
                            );
                          }).toList()
                          
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
                            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 90),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 132,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryGray,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: MaterialButton(
                                    onPressed: (){
                                      if (point > 0) { 
                                        skipClick(likes[currenIndex].id);
                                      } else {
                                        buyPointAlert(context);
                                      }
                                    },
                                    child: Center(
                                      child: CustomText(
                                        text: "スキップ", 
                                        fontSize: 16, 
                                        fontWeight: FontWeight.normal, 
                                        lineHeight: 1, 
                                        letterSpacing: -1, 
                                        color: AppColors.primaryWhite
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 132,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryGreen,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: MaterialButton(
                                    onPressed: (){
                                      if (point > 0) {
                                        thanksClick(likes[currenIndex].id, likes[currenIndex].avatars[0], likes[currenIndex].name);
                                      } else {
                                        buyPointAlert(context);
                                      }
                                    },
                                    child: Center(
                                      child: CustomText(
                                        text: "ありがとう", 
                                        fontSize: 16, 
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            if(likes.isEmpty)
              Center(
                child: CustomContainer(
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackground
                  ),
                  child: Center(
                    child: Container(
                      width: 345,
                      height: 215,
                      padding: const EdgeInsets.only(top: 46, bottom: 26),
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhite,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.secondaryGray.withOpacity(0.5), // Shadow color
                            spreadRadius: 0.5, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: const Offset(0, 1), // Shadow position (x, y)
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "まずは\nアプローチを開始しよう",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              letterSpacing: -1
                            ),
                          ),
                          Container(
                            width: 280,
                            height: 46,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryGreen,
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/swipe");
                              },
                              child: Center(
                                child: CustomText(
                                  text: "おすすめ会員を表示", 
                                  fontSize: 16, 
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
                    ),
                  )
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
                        text: "もらったいいね一覧　${likes.length}件", 
                        fontSize: 16, 
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
