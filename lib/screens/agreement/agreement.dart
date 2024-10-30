import 'package:rinlin/components/agreement/agreement_card.dart';
import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_button.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/models/post_model.dart';
import 'package:rinlin/state/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class AgreementScreen extends StatefulWidget {

  const AgreementScreen({super.key});

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {

  late List<PostModel> myPosts;
  int myPostNewMessages = 0;
  bool isLoding = false;

  @override
  void initState() {
    getMyPost();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getMyPost() async{
    await Provider.of<PostState>(context, listen: false).getMyPost();
    setState(() {
      myPosts = Provider.of<PostState>(context, listen: false).myPosts;
      Provider.of<PostState>(context, listen: false).myPosts.map((item){
        if (item.newNessageCount != null) {
          myPostNewMessages = myPostNewMessages+ item.newNessageCount!;
        }
      }).toList();
      isLoding = true;
    });
  }

  Future clearNewMessageCount(int id) async{
    await Provider.of<PostState>(context, listen: false).clearNewMessageCount(id);
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
            if(myPosts.isNotEmpty)
              Center(
               child: CustomContainer(
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground
                ),
                 child: SingleChildScrollView(
                   child: Padding(
                     padding: const EdgeInsets.only(top: 10, bottom: 50),
                     child: Column(
                       children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 94),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: myPosts.map((post){
                              return MaterialButton(
                                onPressed: () {
                                  if (post.messageCount == 0) {              
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
                                                "情報を保存できませんでした。",
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
                                  }else{
                                    if (myPostNewMessages > 0) {
                                      clearNewMessageCount(post.id);
                                    }
                                    Navigator.pushNamed(context, "/agreenment_chatlist", arguments: PostModel(post.id, post.userId, post.name, post.description, post.prefectureId, post.age, post.avatar, post.backImage, post.messageCount, post.newNessageCount));
                                  }
                                },
                                child: AgreementItem(
                                  name: post.name, 
                                  prefectureId: post.prefectureId, 
                                  age: post.age, 
                                  description: post.description, 
                                  bgImage: post.backImage, 
                                  avatarImage: post.avatar
                                ),
                              );
                            }).toList()
                          ),
                        ),
                       ],
                     ),
                   ),
                 ),
               ),
             ),
             if(myPosts.isEmpty)
              Center(
                child: CustomContainer(
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackground
                  ),
                  child: Center(
                    child: CustomText(
                      text: "投稿した共感はありません", 
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color: AppColors.secondaryGreen
                    ),
                  )
                ),
              ),
             if(myPosts.isEmpty)
              Center(
                child: CustomContainer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 80),
                        child: CustomButton(
                          title: "共感を求める",
                          width: 343,
                          height: 45,
                          fontSize: 17, 
                          fontWeight: FontWeight.normal, 
                          color: AppColors.secondaryGreen, 
                          titleColor: AppColors.primaryWhite, 
                          onTap: () { 
                            Navigator.pushNamed(context, "/postpage");
                          }
                        )
                      )
                    ],
                  ),
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
                        text: "投稿管理", 
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
            ),
             Center(
              child: CustomContainer(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(top:46),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () async {
                          const storage = FlutterSecureStorage();
                          String? gender =  await storage.read(key: 'gender');
                          if (gender != null) {
                            if (int.parse(gender) == 1) {
                              Navigator.pushNamed(context, "/malemypage");
                            } else {
                              Navigator.pushNamed(context, "/femalemypage");
                            }
                          }
                        }, 
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: AppColors.primaryWhite,
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
          ],
        ):const CustomContainer(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ),
    );
  }
}
