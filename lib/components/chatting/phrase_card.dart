import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/phrase_model.dart';
import 'package:flutter/material.dart';

class PhraseItem extends StatelessWidget{
  const PhraseItem({
    super.key, required this.id, required this.text, required this.editPress
 });

 final int id;
 final String text;
 final VoidCallback editPress;

  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 18, right: 17, top: 24.5, bottom: 30),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryGray,
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: editPress,
            child: SizedBox(
              width: 250,
              child: CustomText(
                text: text, 
                fontSize: 13, 
                fontWeight: FontWeight.normal, 
                lineHeight: 1.5, 
                letterSpacing: 1, 
                color: AppColors.primaryBlack
              ),
            )
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.secondaryGreen,
              borderRadius: BorderRadius.circular(50),
            ),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/edit_phrase", arguments: PhraseModel(id, text));
              },
              child: Center(
                child: Image.asset("assets/images/pen.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}