import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/user_model.dart';
import 'package:drone/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReceivedMessageItem extends StatefulWidget{
  const ReceivedMessageItem({
    super.key, required this.text, required this.avatar, required this.date, this.image, required this.onPressed,
  });

  final String text;
  final String avatar;
  final String date;
  final String? image;
  final VoidCallback onPressed;

  @override
  State<ReceivedMessageItem> createState() => _ReceivedMessageItemState();
}

class _ReceivedMessageItemState extends State<ReceivedMessageItem> {
  late UserModel user;
  String formatTime(DateTime date) {
    DateFormat timeFormat = DateFormat('HH:mm');
    return timeFormat.format(date);
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getUser() async{
    setState(() {
      user = Provider.of<UserState>(context, listen: false).user!;
    });
  }

  bool checkedUser() {
    if (user.gender == 1) {
      if (user.isPay && user.isVerify || user.experience) {
        return true;
      } else {
        return false;
      }
    } else {
      if (user.isVerify || user.experience) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 43,
                height: 43,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("${dotenv.get('BASE_URL')}/img/${widget.avatar}"),
                    fit: BoxFit.cover,
                  )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if(widget.text != null && widget.text != "" && checkedUser())
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 200.0, // Set the maximum width
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryWhite,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: CustomText(
                          text: widget.text, 
                          fontSize: 15, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1.5, 
                          letterSpacing: -1, 
                          color: AppColors.primaryBlack
                        ),
                      ),
                    ),
                  if(widget.text != null && widget.text != "" && !checkedUser())
                    Container(
                      width: 193,
                      height: 73,
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color: AppColors.primaryWhite,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Container(
                          width: 158,
                          height: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.secondaryGreen
                          ),
                          child: MaterialButton(
                            onPressed: widget.onPressed,
                            child: Center(
                              child: CustomText(
                                text: "メッセージを確認", 
                                fontSize: 11, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: -1, 
                                color: AppColors.primaryWhite
                              ),
                            ),
                          ),
                        ),
                      ),

                  const SizedBox(
                    width: 10,
                  ),
                  CustomText(
                    text: formatTime(DateTime.parse(widget.date)), 
                    fontSize: 13, 
                    fontWeight: FontWeight.normal, 
                    lineHeight: 1, 
                    letterSpacing: 1, 
                    color: AppColors.secondaryGray
                  )
                ],
              ),
              if(widget.image != null)
                Stack(
                  children: [
                    Container(
                      width: 235,
                      height: 145,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage("${dotenv.get('BASE_URL')}/img/${widget.image}"),
                          fit: BoxFit.cover
                        )
                      )
                    ),
                    if(!checkedUser())
                      Container(
                      width: 235,
                      height: 145,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryWhite.withOpacity(0.6)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 158,
                            height: 42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.secondaryGreen
                            ),
                            child: MaterialButton(
                              onPressed: widget.onPressed,
                              child: Center(
                                child: CustomText(
                                  text: "メッセージを確認", 
                                  fontSize: 11, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryWhite
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
            ],
          ),
        ],
      ),
    );
  }
}