import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/user_model.dart';
import 'package:drone/models/usertransfer_model.dart';
import 'package:drone/screens/profile/component/groupedit_component.dart';
import 'package:drone/screens/profile/component/introdcution_component.dart';
import 'package:drone/screens/profile/component/mainphoto_component.dart';
import 'package:drone/screens/profile/component/favoriteimage_component.dart';
import 'package:drone/screens/profile/component/profileinformation_component.dart';
import 'package:drone/screens/profile/component/question_component.dart';
import 'package:drone/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late UserModel user;
  bool isLoding = false;
  @override
  void initState() {
    super.initState();
    getUserInformation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getUserInformation() async{
    setState(() {
      user =  Provider.of<UserState>(context, listen: false).user!;
      isLoding = true;
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
        child: !isLoding?
        const CustomContainer(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ):CustomContainer(
          decoration: BoxDecoration(
            color: AppColors.primaryGray.withOpacity(0.5)
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                 Center(
                  child: Column(
                    children: [
                      MainPhoto(
                        id: user.id, 
                        avatarList: user.avatars
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      const IntroductionWidget(),
                      const SizedBox(
                        height: 30,
                      ),
                      const QuestionsWidget(),
                      const SizedBox(
                        height: 47,
                      ),
                      FavoriteImageWidget(
                        favoriteImage: user.favoriteImage,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const ProfileInformationWidget(),
                      const SizedBox(
                        height: 17,
                      ),
                      const GroupEditWidget()
                      
                    ],
                  ),
                ),
                Center(
                  child: CustomContainer(
                    height: 94,
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                            text: "プロフィール編集", 
                            fontSize: 17, 
                            fontWeight: FontWeight.bold, 
                            lineHeight: 1, 
                            letterSpacing: 1, 
                            color: AppColors.primaryBlack
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () async{
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
                              color: AppColors.primaryBlack,
                            )
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, "/view_profile", arguments: UserTransforIdModel(id: user.id, beforePage: 'edit_profile'));
                            }, 
                            child: CustomText(
                              text: "相手からの見え方", 
                              fontSize: 10, 
                              fontWeight: FontWeight.bold, 
                              lineHeight: 1, 
                              letterSpacing: -1, 
                              color: AppColors.secondaryGreen
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}

