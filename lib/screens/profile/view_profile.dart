import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';

class ViewProfileScreen extends StatefulWidget {

  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: CustomContainer(
        decoration: BoxDecoration(
          color: AppColors.primaryGray.withOpacity(0.5)
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              const Center(
                child: CustomContainer(
                  height: 424,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/gfd.png"),
                      fit: BoxFit.cover     
                    )
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 407),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
                        decoration: BoxDecoration(
                          color: AppColors.primaryWhite,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "自己PR", 
                                fontSize: 15, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomText(
                                text: "私は、日本に住んでいる男性です。初めてアプリを利用しました。\n好きなことは登山と釣りをすることです。休日はよくキャンプに出かけます。いつもは一人ですが、いい人がいたら一緒に行きたいです。他には、仕事はIT系です。土日が休みなので同じ休みの日の人がいたら嬉しいです。\nとにかく素敵な人と出会いって結婚をスタートしたいです。", 
                                fontSize: 14, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1.5, 
                                letterSpacing: -1, 
                                color: AppColors.primaryBlack
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColors.primaryWhite,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "自己PR", 
                                fontSize: 15, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Column(
                                children: [
                                  ProfileItem(
                                    label: "居住地", text: "東京都"
                                  ),
                                  ProfileItem(
                                    label: "身長", text: "150cm"
                                  ),
                                  ProfileItem(
                                    label: "体型", text: "普通"
                                  ),
                                  ProfileItem(
                                    label: "血液型", text: "A型"
                                  ),
                                  ProfileItem(
                                    label: "出身地", text: "東京都"
                                  ),
                                  ProfileItem(
                                    label: "学歴", text: "短大・専門卒"
                                  ),
                                  ProfileItem(
                                    label: "職種", text: "教育関連"
                                  ),
                                  ProfileItem(
                                    label: "年収", text: "400万円〜600万円"
                                  ),
                                  ProfileItem(
                                    label: "結婚歴", text: "独身(離婚)"
                                  ),
                                  ProfileItem(
                                    label: "結婚に対する意思", text: "2〜3年以内にしたい"
                                  ),
                                  ProfileItem(
                                    label: "子供の有無", text: "同居中"
                                  ),
                                  ProfileItem(
                                    label: "家事や育児", text: "参加したい"
                                  ),
                                  ProfileItem(
                                    label: "出会うまでの希望", text: "まずは会って話したい"
                                  ),
                                  ProfileItem(
                                    label: "初回デート費用", text: "割り勘"
                                  ),
                                ],
                              )
                            ],
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
      )
    );
  }
}

class ProfileItem extends StatelessWidget{
  const ProfileItem({
    super.key, required this.label, required this.text
 });

 final String label;
 final String text;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top:20, right: 15),
      child: Container(
        padding: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.primaryGray,
              width: 1
            )
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: label, 
              fontSize: 13, 
              fontWeight: FontWeight.normal, 
              lineHeight: 1, 
              letterSpacing: 1, 
              color: AppColors.primaryBlack
            ),
            CustomText(
              text: text, 
              fontSize: 13, 
              fontWeight: FontWeight.normal, 
              lineHeight: 1, 
              letterSpacing: 1, 
              color: AppColors.secondaryGreen
            )
          ],
        ),
      ),
    );
  }
}
