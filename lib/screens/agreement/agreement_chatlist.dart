import 'package:drone/components/agreement/agreement_chatcard.dart';
import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/post_model.dart';
import 'package:drone/models/postmessage_model.dart';
import 'package:drone/state/post_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgreementChatListScreen extends StatefulWidget {

  const AgreementChatListScreen({super.key});

  @override
  State<AgreementChatListScreen> createState() => _AgreementChatListScreenState();
}

class _AgreementChatListScreenState extends State<AgreementChatListScreen> {

  late List<PostMessageModel> messageList;
  bool isLoding = false;
  @override
  void initState() {
    getPostChatList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getPostChatList() async{
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final args = ModalRoute.of(context)!.settings.arguments as PostModel;
      await Provider.of<PostState>(context, listen: false).getPostMessageList(args.id);
      // await Provider.of<UserState>(context, listen: false).getGroupList();
      setState(() {
        messageList = Provider.of<PostState>(context, listen: false).postMessageList;
        isLoding = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushNamed(context, "/agreement");
        return true;
      },
      child: BaseScreen(
        child: isLoding? Stack(
          children: [
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
                            children: messageList.map((message){
                              return AgreementChatItem(
                                id:message.senderId,
                                name: message.name, 
                                prefectureId: message.prefectureId, 
                                age: message.age, 
                                content: message.content, 
                                avatarImage: message.avatarImage
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
                        onPressed: (){
                          // Navigator.pushNamed(context, "/agreement");
                          Navigator.pop(context);
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
        ): const CustomContainer(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ),
    );
  }
}
