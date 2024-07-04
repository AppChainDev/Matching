
import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/pilotid_model.dart';
import 'package:flutter/material.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';

class FindPilotScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  FindPilotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Stack(
        children: [
           Center(
             child: CustomContainer(
              width: 375.0,
              height: 812.0,
              child: Image.asset(
                "assets/images/white_back.png",
                fit: BoxFit.cover
              ),
             ),
           ),
           Center(
            child: CustomContainer(
              width: 375.0,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(top:30, left:20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // SizedBox(
                    //   width: 20,
                    //   child: IconButton(
                    //     onPressed: (){
                    //       Navigator.pop(context);
                    //     }, 
                    //     icon: Image.asset("assets/images/back_mark.png", fit: BoxFit.cover,)
                    //   ),
                    // ),
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        onPressed: (){
                          Navigator.pushNamed(context, "/settingpilot");
                        }, 
                        icon: Image.asset("assets/images/back_settingicon.png", fit: BoxFit.cover,)
                      ),
                    ),
                  ],
                ),
              ),
            ),
           ),
           Center(
             child: Padding(
              padding: const EdgeInsets.only(top: 44),
              child: CustomText(
                text: "パイロットを探す",
                fontSize: 16, 
                fontWeight: FontWeight.bold, 
                color: AppColors.primaryBlack,
                lineHeight: 1.5,
                letterSpacing: 1,
              )
             ),
           ),
           Center(
             child: CustomContainer(
               width: 375,
               height: 812,
               child: Padding(
                padding: const EdgeInsets.only(top: 103, bottom: 81),
                 child: SingleChildScrollView(
                   child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/pilotprofile", arguments: PilotidIdModel(id: 1, name: "パイロットネーム007"));
                        },
                        child: const PilotItem(
                          id: 1,
                          name: "パイロットネーム007 ", 
                          prefecture: "新潟県", 
                          categories: ["カテゴリー名", "カテゴリー名", "カテゴリー名"], 
                          qualification: "一等無人航空機操縦士"
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/pilotprofile", arguments: PilotidIdModel(id: 2, name: "パイロットネーム006"));
                        },
                        child: const PilotItem(
                          id: 2,
                          name: "パイロットネーム006 ", 
                          prefecture: "新潟県", 
                          categories: ["カテゴリー名", "カテゴリー名", "カテゴリー名"], 
                          qualification: "一等無人航空機操縦士"
                        ),
                      )
                      // Flexible(
                      //   child: FutureBuilder(
                      //     future: getRequest(),
                      //     builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                      //       if (snapshot.data == null) {
                      //         return const Center(
                      //           child: CircularProgressIndicator(),
                      //         );
                      //       } else {
                      //         return ListView.builder(
                      //             padding: const EdgeInsets.only(top:0),
                      //             itemCount: snapshot.data.length,
                      //             itemBuilder: (ctx, index) => 
                      //             MaterialButton(
                      //               onPressed: () {
                      //               },
                      //               child: DataListItem(title: snapshot.data[index].title, type: snapshot.data[index].type, time: snapshot.data[index].time, imageUrl: snapshot.data[index].main_image_url)
                      //               ));
                      //       }
                      //     },
                      //   ),
                      // ),
                    ],
                   ),
                 ),
               ),
             ),
           ),
           Center(
             child: CustomContainer(        
              width: 375,
              height: 812,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                  height: 81,
                  color: AppColors.primaryWhite,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 94,
                        child: MaterialButton(
                          onPressed: () {
                            
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  const AssetImage("assets/images/bx-search.png"),
                                  color: AppColors.secondaryBlue,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                CustomText(
                                  text: "探す", 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.secondaryBlue
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 94,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/clientjoblist");
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const ImageIcon(
                                  AssetImage("assets/images/bx-clipboard.png")
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                CustomText(
                                  text: "依頼一覧", 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.secondaryGray
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  const AssetImage("assets/images/bx-message-detail.png"),
                                  color: AppColors.secondaryGray,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                CustomText(
                                  text: "メッセージ", 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.secondaryGray
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 94,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/paymentlist");
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const ImageIcon(
                                  AssetImage("assets/images/bx-wallet.png")
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                CustomText(
                                  text: "支払履歴", 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.secondaryGray
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  )
                ],
              )
             ),
           )
        ],
      )
    );
  }
}

class PilotItem extends StatelessWidget{
  final int id;
  final String name;
  final String prefecture;
  final List<String> categories;
  final String qualification;

  const PilotItem({
    super.key,
    required this.id,
    required this.name,
    required this.prefecture,
    required this.categories,
    required this.qualification
  });

  @override
  Widget build(BuildContext context){
    return Container(
      width: 335,
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryGray.withOpacity(0.5), // Shadow color
            spreadRadius: 0.5, // Spread radius
            blurRadius: 5, // Blur radius
            offset: const Offset(0, 1), // Shadow position (x, y)
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 14, left: 18, right: 18, bottom: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlack,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: AppColors.primaryBlack
                  ),
                ),
                Container(
                  width: 60,
                  height: 22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.primaryGreen
                  ),
                  child: Center(
                    child: Text(
                      prefecture,
                      style: TextStyle(
                        color: AppColors.primaryWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 6.6,
              children: categories.map((category){
                return Container(
                  width: 90,
                  height: 29,
                  margin: const EdgeInsets.only(right: 5, bottom: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryBlack,
                      width: 1
                    )
                  ),
                  child: Center(
                    child: CustomText(
                      text: category, 
                      fontSize: 12, 
                      fontWeight: FontWeight.bold, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color: AppColors.primaryBlack
                    ),
                  ),
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const ImageIcon(
                  AssetImage("assets/images/bx-credit-card-front.png")
                ),
                const SizedBox(
                  width: 6,
                ),
                CustomText(
                  text: "保有資格", 
                  fontSize: 12, 
                  fontWeight: FontWeight.bold, 
                  lineHeight: 1, 
                  letterSpacing: 1, 
                  color: AppColors.secondaryGray
                ),
                const SizedBox(
                  width: 6,
                ),
                CustomText(
                  text: qualification, 
                  fontSize: 13, 
                  fontWeight: FontWeight.bold, 
                  lineHeight: 1, 
                  letterSpacing: 1, 
                  color: AppColors.primaryBlack
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
