import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/models/notification_model.dart';
import 'package:rinlin/state/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  late List<NotificationModel> notifications;
  bool isLoding = false;

  @override
  void initState() {
    getNotifications();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getNotifications() async{
    await Provider.of<NotificationState>(context, listen: false).getNotifications();
    setState(() {
      notifications = Provider.of<NotificationState>(context, listen: false).notifications;
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
        child: isLoding? Stack(
          children: [
            if(notifications.isNotEmpty)
              Center(
              child: CustomContainer(
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 137),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: notifications.map((notification){
                      return MaterialButton(
                        onPressed: () async{
                          await Provider.of<NotificationState>(context, listen: false).addUserToNotification(notification.id);
                          Navigator.pushNamed(context, "/notification_detail", arguments: NotificationModel(notification.id, notification.title, notification.content, notification.usersArray));
                        },
                        child: NotificationItem(
                          id: notification.id, 
                          text: notification.title
                        ),
                      );
                    }).toList()
                  ),
                ),
              ),
              ),
            if(notifications.isEmpty)
              Center(
                child: CustomContainer(
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackground
                  ),
                  child: Center(
                    child: CustomText(
                      text: "メッセージはありません", 
                      fontSize: 14, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 1, 
                      letterSpacing: -1, 
                      color: AppColors.secondaryGreen
                    ),
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
                      text: "お知らせ", 
                      fontSize: 17, 
                      fontWeight: FontWeight.bold, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color:AppColors.primaryWhite
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CustomContainer(
                height: 94,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: ()async{
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
                  ],
                ),
              ),
            ),
          ),
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


class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.id, required this.text});
  
  final int id;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: text, 
            fontSize: 14, 
            fontWeight: FontWeight.normal, 
            lineHeight: 1, 
            letterSpacing: 1, 
            color: AppColors.primaryBlack
          ),
          Icon(
            Icons.keyboard_arrow_right_rounded,
            color: AppColors.secondaryGray.withOpacity(0.5),
            size: 30,
          ),
        ],
      ),
    );
  }
}
