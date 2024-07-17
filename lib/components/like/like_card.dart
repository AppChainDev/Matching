import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

class LikeItem extends StatefulWidget{
 const LikeItem({super.key, required this.id, required this.name, required this.prefectureId, required this.age, required this.avatars, required this.pressSkip, required this.pressThanks, required this.verify, this.description, this.pressProfile, required this.favourite, this.favouriteTitle, this.favouriteText, this.favouriteImage});
 final int id;
 final String name;
 final int prefectureId;
 final int age;
 final String? description;
 final List<String> avatars;
 final VoidCallback pressSkip;
 final VoidCallback pressThanks;
 final VoidCallback? pressProfile;
 final bool verify;
 final bool favourite;
 final String? favouriteTitle;
 final String? favouriteText;
 final String? favouriteImage;

  @override
  State<LikeItem> createState() => _LikeItemState();
}

class _LikeItemState extends State<LikeItem> {
  late String currentAvatar;
  @override
  void initState() {
    super.initState();
    currentAvatar = widget.avatars[0];
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeAvatarRight(){
    int length = widget.avatars.length;
    print("right");
    int index = widget.avatars.indexOf(currentAvatar);
    if(index+1 < length){
      setState(() {
        currentAvatar = widget.avatars[index+1];
      });
    }
  }
  void changeAvatarLeft(){
    print("right");
    int index = widget.avatars.indexOf(currentAvatar);
    if(index > 0){
      setState(() {
        currentAvatar = widget.avatars[index-1];
      });
    }
  }

  @override
  Widget build(BuildContext context){
    if (widget.description != null) {   
      return Padding(
        padding: const EdgeInsets.only(left:20, right: 20, top: 50),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 610,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 439,
                      padding: const EdgeInsets.only(top: 100, bottom: 32, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhite,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 289, 
                            height: 22,
                            child: Image.asset("assets/images/like_line.png", fit: BoxFit.contain),
                          ),
                          Expanded(
                            child: CustomText(
                              text: widget.description!, 
                              fontSize: 14, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1.5, 
                              letterSpacing: -1, 
                              color: AppColors.secondaryGreen
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
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
                            onPressed: widget.pressSkip,
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
                            onPressed: widget.pressThanks,
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
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/${widget.avatars[0]}"),
                            fit: BoxFit.cover     
                          ),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: AppColors.primaryWhite
                          ),
                        ),
                      ),
                      CustomText(
                        text: widget.name, 
                        fontSize: 12, 
                        fontWeight: FontWeight.normal, 
                        lineHeight: 1.5, 
                        letterSpacing: 1, 
                        color: AppColors.secondaryGreen
                      ),
                      CustomText(
                        text: "特別なメッセージが届きました", 
                        fontSize: 12, 
                        fontWeight: FontWeight.normal, 
                        lineHeight: 1.5, 
                        letterSpacing: 1, 
                        color: AppColors.secondaryGreen
                      )
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      );
    } else{
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left:5, right: 5, top: 50),
        child: SizedBox(
          height: 623,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 560,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/$currentAvatar"),
                        fit: BoxFit.cover     
                      ),
                      color: AppColors.darkGray,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(
                    height: 560,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 17, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: widget.avatars.map((avatar){
                              return Container(
                                width: 60,
                                height: 3,
                                margin: const EdgeInsets.only(right: 5),
                                color: avatar == currentAvatar?AppColors.primaryWhite:AppColors.primaryBlack.withOpacity(0.3),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                AppColors.primaryBlack.withOpacity(0.8),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if(widget.verify)
                    SizedBox(
                      height: 560,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 70,
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 110,
                                  height: 27,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBlue,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      text: "認証済みユーザー", 
                                      fontSize: 12, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1, 
                                      letterSpacing: -1, 
                                      color: AppColors.primaryWhite
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SwipeTo(
                        child: GestureDetector(
                          onTap: () {
                            changeAvatarLeft();
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width-40)/2,
                            height: 560,
                            color: Colors.transparent,
                          ),
                        ),
                        onLeftSwipe: (details) {
                          widget.pressSkip();
                        },
                      ),
                      SwipeTo(
                        child: GestureDetector(
                          onTap: (){
                            changeAvatarRight();
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width-40)/2,
                            height: 560,
                            color: Colors.transparent,
                          ),
                        ),
                        onRightSwipe: (details) {
                          widget.pressThanks();
                        },
                      )
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          onPressed: widget.pressProfile,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(bottom: 45),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "${widget.name}, ${widget.age}", 
                                      fontSize: 18, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1.5, 
                                      letterSpacing: -1, 
                                      color: AppColors.primaryWhite
                                    ),
                                    CustomText(
                                      text: ConstFile.prefectureItems[widget.prefectureId], 
                                      fontSize: 18, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1.5, 
                                      letterSpacing: -1, 
                                      color: AppColors.primaryWhite
                                    ),
                                    if(widget.favourite == true)
                                      Container(
                                        height: 74,
                                        width: MediaQuery.of(context).size.width*0.83,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryWhite,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 67,
                                              height: 67,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                 image: DecorationImage(
                                                    image: AssetImage("assets/images/${widget.favouriteImage!}"),
                                                    fit: BoxFit.cover     
                                                  ), 
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            Column(
                                              mainAxisAlignment:MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5),
                                                  child: CustomText(
                                                    text: widget.favouriteTitle!, 
                                                    fontSize: 12, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 2, 
                                                    letterSpacing: -1, 
                                                    color: AppColors.secondaryGreen
                                                  ),
                                                ),
                                                CustomText(
                                                  text: widget.favouriteText!, 
                                                  fontSize: 9, 
                                                  fontWeight: FontWeight.normal, 
                                                  lineHeight: 1.5, 
                                                  letterSpacing: -1, 
                                                  color: AppColors.primaryBlack
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )

                                  ]
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                          onPressed: widget.pressSkip,
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
                          onPressed: widget.pressThanks,
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
                  )
                ],
              )

            ],
          ),
        ),
      );
    }
  }
}