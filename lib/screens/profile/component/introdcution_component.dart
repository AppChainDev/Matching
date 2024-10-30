import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroductionWidget extends StatefulWidget{
  const IntroductionWidget({
    super.key
 });

  @override
  State<IntroductionWidget> createState() => _IntroductionWidgetState();
}

class _IntroductionWidgetState extends State<IntroductionWidget> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 470,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(20)
      ),
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
          Expanded(
            child: SingleChildScrollView(
              child: CustomText(
                text: Provider.of<UserState>(context, listen: false).user!.introduce, 
                fontSize: 14, 
                fontWeight: FontWeight.normal, 
                lineHeight: 1.5, 
                letterSpacing: -1, 
                color: AppColors.primaryBlack
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Container(
                width: 170,
                height: 47,
                decoration: BoxDecoration(
                  color: AppColors.secondaryGreen,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: MaterialButton(
                  onPressed: () async{
                    await Navigator.pushNamed(context, "/edit_introduce");
                  },
                  child: Center(
                    child: CustomText(
                      text: "編集", 
                      fontSize: 14, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color: AppColors.primaryWhite
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}