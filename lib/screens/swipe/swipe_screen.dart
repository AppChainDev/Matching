
import 'dart:async';

import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_button.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/components/swipe/circle_thumbshape.dart';
import 'package:rinlin/components/swipe/group_card.dart';
import 'package:rinlin/components/swipe/group_other_card.dart';
import 'package:rinlin/components/swipe/group_prefecture_card.dart';
import 'package:rinlin/components/swipe/swipe_card.dart';
import 'package:rinlin/models/category_model.dart';
import 'package:rinlin/models/chattingtransfer_model.dart';
import 'package:rinlin/models/like_model.dart';
import 'package:rinlin/models/swipegroup_model.dart';
import 'package:rinlin/models/usertransfer_model.dart';
import 'package:rinlin/state/like_state.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:rinlin/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class SwipeScreen extends StatefulWidget {

  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}
String pageKey = "swipe";
class _SwipeScreenState extends State<SwipeScreen> {

  late List<LikeModel> users;
  bool isLoding = false;
  late List<SwipeGroupModel> topGroups;
  late List<SwipeGroupModel> allSwipeGroups;
  List<Category> categoryList = [];
  int currenIndex = 0;
  late int point;
  bool clickedSearch = false;
  List<int> prefectureIds = [];
  List<int> bodyTypes= [];
  List<int> maritalHistories = [];
  List<int> attitudes = [];
  RangeValues ageRangeValues = const RangeValues(40, 40);
  RangeValues heightRangeValues = const RangeValues(130, 130);

  @override
  void initState() {
    getInitial();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getInitial() async{
    await Provider.of<UserState>(context, listen: false).getUsers();
    await Provider.of<UserState>(context, listen: false).getTopGroups();
    await Provider.of<UserState>(context, listen: false).getSwipeAllGroups();
    await Provider.of<UserState>(context, listen: false).getCategoryList();
    setState(() {
      users = Provider.of<UserState>(context, listen: false).users;
      topGroups = Provider.of<UserState>(context, listen: false).topGroups;
      allSwipeGroups = Provider.of<UserState>(context, listen: false).allSwipeGroups;
      point = Provider.of<UserState>(context, listen: false).user!.pointCount;
      categoryList = Provider.of<UserState>(context, listen: false).categories;
      isLoding = true;
    });
  }

  Future searchSwipeUser() async{
    await Provider.of<UserState>(context, listen: false).searchSwipeUser(
      ageRangeValues.start.ceil(), 
      ageRangeValues.end.ceil(),
      heightRangeValues.start.ceil(),
      heightRangeValues.end.ceil(),
      prefectureIds,
      bodyTypes,
      maritalHistories,
      attitudes 
    );
    setState(() {
      users = Provider.of<UserState>(context, listen: false).swipeSearchUsers;
      clickedSearch = false;
      ageRangeValues = const RangeValues(40, 40);
      heightRangeValues = const RangeValues(130, 130);
      prefectureIds = [];
      bodyTypes = [];
      maritalHistories = [];
      attitudes = [];
    });
  }

  Future likeClick(int id) async{
    final result = await Provider.of<LikeState>(context, listen: false).sendLike(id);
    if (result) {
      await Provider.of<UserState>(context, listen: false).getUserInformation(); 
      setState(() {  
        point = Provider.of<UserState>(context, listen: false).user!.pointCount;
        users.removeWhere((item)=>item.id==id);
        if (users.isEmpty) {
          currenIndex = 0;
        } else {
          currenIndex = (currenIndex >= users.length) ? users.length - 1 : currenIndex;
        }
      });
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

  Future skipClick(int id) async{
    final result = await Provider.of<LikeState>(context, listen: false).skipSwipe();
    if (result) {
      await Provider.of<UserState>(context, listen: false).getUserInformation(); 
      setState(() {
        point = Provider.of<UserState>(context, listen: false).user!.pointCount;
        users.removeWhere((item)=>item.id==id);
        if (users.isEmpty) {
          currenIndex = 0;
        } else {
          currenIndex = (currenIndex >= users.length) ? users.length - 1 : currenIndex;
        }
      }); 
    }
  }
  void handleChange(String text) {
    setState(() {
      pageKey = text;
    });
  }
  void handlePrefecture(String text) {
    setState(() {
      if (prefectureIds.contains(ConstFile.prefectureItems.indexOf(text))) {
        prefectureIds.remove(ConstFile.prefectureItems.indexOf(text));
      } else {
        prefectureIds.add(ConstFile.prefectureItems.indexOf(text));
      }
    });
  }
  void handleBodyTypes(String text) {
    setState(() {
      if (bodyTypes.contains(ConstFile.bodyTypes.indexOf(text))) {
        bodyTypes.remove(ConstFile.bodyTypes.indexOf(text));
      } else {
        bodyTypes.add(ConstFile.bodyTypes.indexOf(text));
      }
    });
  }
  void handleMaritalHistories(String text) {
    setState(() {
      if (maritalHistories.contains(ConstFile.maritalHistories.indexOf(text))) {
        maritalHistories.remove(ConstFile.maritalHistories.indexOf(text));
      } else {
        maritalHistories.add(ConstFile.maritalHistories.indexOf(text));
      }
    });
  }
  void handleAttitudes(String text) {
    setState(() {
      if (attitudes.contains(ConstFile.attitudes.indexOf(text))) {
        attitudes.remove(ConstFile.attitudes.indexOf(text));
      } else {
        attitudes.add(ConstFile.attitudes.indexOf(text));
      }
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

  Widget searchWidget(){
    return 
      Center(
        child: CustomContainer(
          decoration: BoxDecoration(
            color: AppColors.primaryBlack.withOpacity(0.3)
          ),
          child: Padding(
            padding: const EdgeInsets.only(top:130),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-118,
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
                        padding: const EdgeInsets.only(top: 20, bottom: 60),
                        child: Center(
                          child: CustomText(
                            text: "検索条件", 
                            fontSize: 14, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1, 
                            letterSpacing: 1, 
                            color: AppColors.primaryBlack
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                margin: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: "年齢", 
                                      fontSize: 14, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryBlack
                                    ),
                                    CustomText(
                                      text: (ageRangeValues.start == 40 && ageRangeValues.end == 40)?"問わない":"${(ageRangeValues.start).toInt()}~${(ageRangeValues.end).toInt()}", 
                                      fontSize: 14, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryBlack
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    rangeThumbShape: const CircleThumbShape(),
                                    inactiveTrackColor: AppColors.primaryGray
                                  ),
                                  child: RangeSlider(
                                    values: ageRangeValues,
                                    max: 110,
                                    min: 40,
                                    divisions: 70,
                                    activeColor: AppColors.secondaryGreen,
                                    labels: RangeLabels(
                                      ageRangeValues.start.round().toString(),
                                      ageRangeValues.end.round().toString(),
                                    ),
                                    onChanged: (RangeValues values) {
                                      setState(() {
                                        ageRangeValues = values;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                margin: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: "身長", 
                                      fontSize: 14, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryBlack
                                    ),
                                    CustomText(
                                      text: (heightRangeValues.start == 130 && heightRangeValues.end == 130)?"問わない":"${(heightRangeValues.start).toInt()}cm~${(heightRangeValues.end).toInt()}cm", 
                                      fontSize: 14, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryBlack
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    rangeThumbShape: const CircleThumbShape(),
                                    inactiveTrackColor: AppColors.primaryGray
                                  ),
                                  child: RangeSlider(
                                    values: heightRangeValues,
                                    max: 210,
                                    min: 130,
                                    divisions: 80,
                                    activeColor: AppColors.secondaryGreen,
                                    
                                    labels: RangeLabels(
                                      heightRangeValues.start.round().toString(),
                                      heightRangeValues.end.round().toString(),
                                    ),
                                    onChanged: (RangeValues values) {
                                      setState(() {
                                        heightRangeValues = values;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: CustomText(
                                  text: "居住地(右にスクロール)", 
                                  fontSize: 14, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryBlack
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Container(
                                height: 150,
                                padding: const EdgeInsets.only(left: 20),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: ConstFile.prefectureItems.sublist(0,16).map((item){
                                            return GestureDetector(
                                              onTap: () {
                                                handlePrefecture(item);
                                              },
                                              child: GroupPrefectureItem(
                                                id: ConstFile.prefectureItems.indexOf(item), 
                                                text: item.replaceAll(RegExp(r'[県]'), ''), 
                                                inChecked: prefectureIds.contains(ConstFile.prefectureItems.indexOf(item))
                                              ),
                                            );
                      
                                          }).toList(),
                                        ),
                                        Row(
                                          children: ConstFile.prefectureItems.sublist(16,32).map((item){
                                            return GestureDetector(
                                              onTap: () {
                                                handlePrefecture(item);
                                              },
                                              child: GroupPrefectureItem(
                                                id: ConstFile.prefectureItems.indexOf(item), 
                                                text: item.replaceAll(RegExp(r'[県]'), ''), 
                                                inChecked: prefectureIds.contains(ConstFile.prefectureItems.indexOf(item))
                                              ),
                                            );
                      
                                          }).toList(),
                                        ),
                                        Row(
                                          children: ConstFile.prefectureItems.sublist(32,ConstFile.prefectureItems.length).map((item){
                                            return GestureDetector(
                                              onTap: () {
                                                handlePrefecture(item);
                                              },
                                              child: GroupPrefectureItem(
                                                id: ConstFile.prefectureItems.indexOf(item), 
                                                text: item.replaceAll(RegExp(r'[県]'), ''), 
                                                inChecked: prefectureIds.contains(ConstFile.prefectureItems.indexOf(item))
                                              ),
                                            );
                      
                                          }).toList(),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: CustomText(
                                  text: "体型", 
                                  fontSize: 14, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryBlack
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: ConstFile.bodyTypes.map((item){
                                    return GestureDetector(
                                      onTap: () {
                                        handleBodyTypes(item);
                                      },
                                      child: GroupOtherItem(
                                        id: ConstFile.bodyTypes.indexOf(item), 
                                        text: item, 
                                        inChecked: bodyTypes.contains(ConstFile.bodyTypes.indexOf(item))
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: CustomText(
                                  text: "結婚歴", 
                                  fontSize: 14, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryBlack
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: ConstFile.maritalHistories.map((item){
                                    return GestureDetector(
                                      onTap: () {
                                        handleMaritalHistories(item);
                                      },
                                      child: GroupOtherItem(
                                        id: ConstFile.maritalHistories.indexOf(item), 
                                        text: item, 
                                        inChecked: maritalHistories.contains(ConstFile.maritalHistories.indexOf(item))
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: CustomText(
                                  text: "結婚に対する意思", 
                                  fontSize: 14, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryBlack
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: ConstFile.attitudes.map((item){
                                    return GestureDetector(
                                      onTap: () {
                                        handleAttitudes(item);
                                      },
                                      child: GroupOtherItem(
                                        id: ConstFile.attitudes.indexOf(item), 
                                        text: item, 
                                        inChecked: attitudes.contains(ConstFile.attitudes.indexOf(item))
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                  title: "この条件で検索", 
                                  width: 343, 
                                  fontSize: 15, 
                                  fontWeight: FontWeight.normal, 
                                  color: AppColors.secondaryGreen, 
                                  titleColor: AppColors.primaryWhite, 
                                  onTap: (){
                                    searchSwipeUser();
                                  }
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){
                          setState(() {
                            clickedSearch = false;
                          });
                        }, 
                        icon: Icon(
                          Icons.close,
                          color: AppColors.primaryBlack,
                          size: 40,
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              clickedSearch = false;
                            });
                          }, 
                          child: CustomText(
                            text: "リセット", 
                            fontSize: 14, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1, 
                            letterSpacing: -1, 
                            color: AppColors.secondaryGreen
                          )
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
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
      child: isLoding? BaseScreen(
        child: pageKey=="swipe"? Stack(
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
                          scale: 0.8,
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
                                pressLike: (){
                                  if (point>0) {
                                    likeClick(users[users.length-1].id);
                                  }else{
                                    buyPointAlert(context);
                                  }
                                },
                                pressProfile: () {
                                  Navigator.pushNamed(context, "/view_profile", arguments: UserTransforIdModel(null, id: users[users.length-1].id, beforePage: 'swipepage'));
                                }, 
                                verify: users[users.length-1].verify, 
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
                                Navigator.pushNamed(context, "/view_profile", arguments: UserTransforIdModel(null, id: item.id, beforePage: 'swipepage'));
                              }, 
                              verify: item.verify, 
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
                                  pressProfile: () {
                                    Navigator.pushNamed(context, "/view_profile", arguments: UserTransforIdModel(null, id: item.id, beforePage: 'swipepage'));
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
                                        if (point>0) {
                                          Navigator.pushNamed(context, "/messagescreen", arguments: ChattingTransferModel(users[currenIndex].id, users[currenIndex].name, users[currenIndex].avatars[0], users[currenIndex].prefectureId, users[currenIndex].age));
                                        }else{
                                          buyPointAlert(context);
                                        }
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
                                setState(() {
                                  users = Provider.of<UserState>(context, listen: false).users;
                                });
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
                              SelectItem(
                                text: "おすすめ", 
                                keyText: "swipe", 
                                inChecked: pageKey == "swipe", 
                                onCartChanged: handleChange
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SelectItem(
                                text: "さがす", 
                                keyText: "search", 
                                inChecked: pageKey == "search", 
                                onCartChanged: handleChange
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                clickedSearch = true;
                              });
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
            bottomBar(),
            if(clickedSearch)
             searchWidget()  
          ]
        ):Stack(
          children: [
            Center(
              child: CustomContainer(
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 260,
                          padding: const EdgeInsets.only(top: 18.5, left: 20),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBackground
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "みんなに人気のグループはコレ！", 
                                fontSize: 8, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 2.5, 
                                letterSpacing: 1, 
                                color: AppColors.secondaryGreen
                              ),
                              CustomText(
                                text: "unique text", 
                                fontSize: 22, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              ),
                              Container(
                                height: 160,
                                margin: const EdgeInsets.only(top: 15),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: topGroups.map((item){
                                    return Container(
                                      width: 98,
                                      margin: const EdgeInsets.only(right: 13),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 98,
                                            height: 98,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: NetworkImage("${dotenv.get('BASE_URL')}/img/${item.thumbnail}"),
                                                fit: BoxFit.cover
                                              )
                                            ),
                                            child: MaterialButton(
                                              onPressed: () {
                                                Navigator.pushNamed(context, "/group_member", arguments: SwipeGroupModel(id: item.id, name: item.name, members: item.members, thumbnail: item.thumbnail, categoryId: 1));
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: item.name, 
                                                fontSize: 12, 
                                                fontWeight: FontWeight.normal, 
                                                lineHeight: 1.5, 
                                                letterSpacing: -1, 
                                                color: AppColors.primaryBlack
                                              ),
                                              CustomText(
                                                text: "${item.members}人", 
                                                fontSize: 12, 
                                                fontWeight: FontWeight.normal, 
                                                lineHeight: 1.5, 
                                                letterSpacing: -1, 
                                                color: AppColors.secondaryGray
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()
                                  
                                ),
                              ),
      
                            ],
                          ),
                        ),
                        Column(
                          children: categoryList.map((category){
                            return Container(
                              padding: const EdgeInsets.only(top: 18, left: 22, bottom: 25),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: category.label, 
                                    fontSize: 17, 
                                    fontWeight: FontWeight.normal, 
                                    lineHeight: 1, 
                                    letterSpacing: -1, 
                                    color: AppColors.secondaryGreen
                                  ),
                                  Container(
                                    height: 250,
                                    margin: const EdgeInsets.only(top: 15),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: allSwipeGroups.where((groupItem){
                                                return groupItem.categoryId == category.id;
                                              }).toList()
                                              .sublist(0, (allSwipeGroups.where((groupItem){
                                                return groupItem.categoryId == category.id;
                                              }).toList().length/2).ceil()).map((item){
                                                return GroupItem(
                                                  id: item.id, 
                                                  name: item.name, 
                                                  members: item.members, 
                                                  thumbnail: item.thumbnail
                                                );
                                              }).toList(),
                                            ),
                                            Row(
                                              children:  allSwipeGroups.where((groupItem){
                                                return groupItem.categoryId == category.id;
                                              }).toList()
                                              .sublist((allSwipeGroups.where((groupItem){
                                                return groupItem.categoryId == category.id;
                                              }).toList().length/2).ceil(), allSwipeGroups.where((groupItem){
                                                return groupItem.categoryId == category.id;
                                              }).toList().length).map((item){
                                                return GroupItem(
                                                  id: item.id, 
                                                  name: item.name, 
                                                  members: item.members, 
                                                  thumbnail: item.thumbnail
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList()
                        ),
                        const SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: CustomContainer(
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 15, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              SelectItem(
                                text: "おすすめ", 
                                keyText: "swipe", 
                                inChecked: pageKey == "swipe", 
                                onCartChanged: handleChange
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SelectItem(
                                text: "さがす", 
                                keyText: "search", 
                                inChecked: pageKey == "search", 
                                onCartChanged: handleChange
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            bottomBar(),
          ],
        )
      ): const BaseScreen(
        child: CustomContainer(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ),
    );
  }
}

typedef CartChangedCallback = Function(String text);

class SelectItem extends StatelessWidget {
  const SelectItem(
    {required this.text,
    required this.keyText,
    required this.inChecked,
    required this.onCartChanged,
    super.key});

  final String text;
  final String keyText;
  final bool inChecked;
  final CartChangedCallback onCartChanged;

  Color backColor(BuildContext context) {
    return inChecked
      ? AppColors.secondaryGreen
      : AppColors.primaryWhite;
  }
  Color textColor(BuildContext context) {
    return inChecked
      ? AppColors.primaryWhite
      : AppColors.secondaryGreen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(
        color: backColor(context),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.secondaryGreen,
          width: 2
        )
      ),
      child: MaterialButton(
        onPressed: () {
          onCartChanged(keyText);
        },
        child: Center(
          child: CustomText(
            text: text, 
            fontSize: 13, 
            fontWeight: FontWeight.normal, 
            lineHeight: 1, 
            letterSpacing: -1, 
            color: textColor(context)
          ),
        ),
      ),
    );
  }
}
