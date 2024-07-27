import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/swipegroup_model.dart';
import 'package:flutter/material.dart';

class GroupItem extends StatelessWidget{
 const GroupItem({super.key, required this.id, required this.name, required this.members, required this.thumbnail});
 final int id;
 final String name;
 final int members;
 final String thumbnail;
 
  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 67,
                height: 67,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("assets/images/$thumbnail"),
                    fit: BoxFit.cover     
                  )
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/group_member", arguments: SwipeGroupModel(id: id, name: name, members: members, thumbnail: thumbnail));
                  }
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: name, 
                    fontSize: 12, 
                    fontWeight: FontWeight.normal, 
                    lineHeight: 1.5, 
                    letterSpacing: -1, 
                    color: AppColors.primaryBlack
                  ),
                  CustomText(
                    text: "$members人", 
                    fontSize: 12, 
                    fontWeight: FontWeight.normal, 
                    lineHeight: 1.5, 
                    letterSpacing: -1, 
                    color: AppColors.secondaryGray
                  )
                ],
              )
            ],
          ),
        ),
    );
  }
}