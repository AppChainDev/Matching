import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/components/swipe/swipe_card.dart';
import 'package:drone/models/chattingtransfer_model.dart';
import 'package:drone/models/like_model.dart';
import 'package:drone/models/usertransfer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SwipeScreen extends StatefulWidget {

  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {

  final List<LikeModel> users = [
    LikeModel(1, "TONBOさんから", null, 12, 50, ["post_backimage1.png"], false, false, null, null),
    LikeModel(2, "ゆうじ", null, 14, 60, ["gfd.png", "aaa.png",], true, false, null, null),
    LikeModel(3, "ゆうじssss", null, 13, 60, ["post_backimage1.png", "gfd.png", "aaa.png"], true, false, null, null),
    LikeModel(4, "ゆうじ111", null, 16, 56, ["post_backimage1.png", "gfd.png", "aaa.png"], false, true, "3年前から飼育しているペットのジョンです。\nかわいいでしょ", "pet.png")
  ];
  int currenIndex = 0;
  int point = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void skipClick(int id){  
      setState(() {
        users.removeWhere((item)=>item.id==id);
        if (users.isEmpty) {
          currenIndex = 0;
        } else {
          currenIndex = (currenIndex >= users.length) ? users.length - 1 : currenIndex;
        }
        point--;
      });
  }
  void likeClick(int id){
    setState(() {
      users.removeWhere((item)=>item.id==id);
      if (users.isEmpty) {
        currenIndex = 0;
      } else {
        currenIndex = (currenIndex >= users.length) ? users.length - 1 : currenIndex;
      }
      point--;
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
                          
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/detection.png"),
                              color: AppColors.secondaryGreen
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              '発見',
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
    return BaseScreen(
      child: Stack(
        children: [
          if(users.isNotEmpty)
            Stack(
              children: [
                Center(
                  child: CustomContainer(
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(top: 100),
                      child: users.length>=2? CardSwiper(
                        cardsCount: users.length,
                        scale: 1.0,
                        isLoop: true,
                        maxAngle: 90,
                        allowedSwipeDirection: const AllowedSwipeDirection.only(left: true, right: true),
                        cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                          if (index >= users.length) {
                            return SwipeItem(
                              id: users[users.length-1].id, 
                              name: users[users.length-1].name, 
                              prefectureId: users[users.length-1].prefectureId, 
                              age: users[users.length-1].age, 
                              avatars: users[users.length-1].avatars, 
                              pressSkip: (){
                                if (point>0) {
                                  skipClick(users[users.length-1].id);
                                }else{
                                  buyPointAlert(context);
                                }
                              }, 
                              pressLike: ()=>likeClick(users[users.length-1].id), 
                              verify: users[users.length-1].verify, 
                              favourite: users[users.length-1].favourite,
                              favouriteText: users[users.length-1].favouriteText,
                              favouriteImage: users[users.length-1].favouriteImage,
                            );
                          }
                          var item = users[index];
                          if (index != 0) {
                            currenIndex = index - 1;
                          } else {
                            currenIndex = (users.length > 1) ? users.length - 1 : 0;
                          }
                          return SwipeItem(
                            id: item.id, 
                            name: item.name,
                            prefectureId: item.prefectureId, 
                            age: item.age, 
                            avatars: item.avatars, 
                            pressSkip: ()=>(){
                              if(point>0){
                                skipClick(users[currenIndex].id);
                              }else{
                                buyPointAlert(context);
                              }
                            }, 
                            pressLike: (){
                              if(point>0){
                                likeClick(users[currenIndex].id);
                              }else{
                                buyPointAlert(context);
                              }
                            }, 
                            pressProfile: () {
                              Navigator.pushNamed(context, "/view_profile", arguments: UserTransforIdModel(id: item.id, beforePage: 'swipepage'));
                            }, 
                            verify: item.verify, 
                            favourite: item.favourite,
                            favouriteText: item.favouriteText,
                            favouriteImage: item.favouriteImage,
                          );               
                        }, 
                      ):Column(
                        children: users.map((item){
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: SwipeItem(
                                id: item.id, 
                                name: item.name, 
                                prefectureId: item.prefectureId, 
                                age: item.age, 
                                avatars: item.avatars, 
                                pressSkip: (){
                                  if (point>0) {
                                    skipClick(item.id);
                                  }else{
                                    buyPointAlert(context);
                                  }
                                },
                                pressLike: (){
                                  if (point>0) {
                                    likeClick(item.id);  
                                  }else{
                                    buyPointAlert(context);
                                  }
                                },
                                verify: item.verify, 
                                favourite: item.favourite,
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
                          padding: const EdgeInsets.only(bottom: 90),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryGray.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: (){
                                      if (point>0) {
                                        skipClick(users[currenIndex].id);
                                      } else {
                                        buyPointAlert(context);
                                      }
                                    }, 
                                    icon: ImageIcon(
                                      const AssetImage("assets/images/close_button.png"),
                                      color: AppColors.primaryWhite
                                    )
                                  )
                                ),
                              ),
                              const SizedBox(
                                width: 28.6,
                              ),
                              Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryRed,
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: (){
                                      Navigator.pushNamed(context, "/messagescreen", arguments: ChattingTransferModel(users[currenIndex].id, users[currenIndex].name, users[currenIndex].avatars[0], users[currenIndex].prefectureId, users[currenIndex].age));
                                    }, 
                                    icon: ImageIcon(
                                      const AssetImage("assets/images/like.png"),
                                      color: AppColors.primaryWhite
                                    )
                                  )
                                ),
                              ),
                              const SizedBox(
                                width: 28.6,
                              ),
                              Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryGreen,
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: (){
                                      if (point>0) {
                                        likeClick(users[currenIndex].id);
                                      }else{
                                        buyPointAlert(context);
                                      }
                                    }, 
                                    icon: ImageIcon(
                                      const AssetImage("assets/images/heart.png"),
                                      color: AppColors.primaryWhite
                                    )
                                  )
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          if(users.isEmpty)
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
                      borderRadius: BorderRadius.circular(10)
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
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryWhite
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.secondaryGreen,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  
                                },
                                child: Center(
                                  child: CustomText(
                                    text: "おすすめ", 
                                    fontSize: 16, 
                                    fontWeight: FontWeight.normal, 
                                    lineHeight: 1, 
                                    letterSpacing: -1, 
                                    color: AppColors.primaryWhite
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: AppColors.secondaryGreen,
                                  width: 2
                                )
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  
                                },
                                child: Center(
                                  child: CustomText(
                                    text: "さがす", 
                                    fontSize: 16, 
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
                        GestureDetector(
                          onTap: () {
                            
                          },
                          child: ImageIcon(
                            const AssetImage("assets/images/search.png"),
                            color: AppColors.secondaryGreen,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomBar()
          
        ],
      )
    );
  }
}
