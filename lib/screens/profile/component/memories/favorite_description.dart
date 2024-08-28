import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteDescriptionWidget extends StatefulWidget {
  const FavoriteDescriptionWidget({super.key});

  @override
  State<FavoriteDescriptionWidget> createState() => _FavoriteDescriptionWidgetState();
}

class _FavoriteDescriptionWidgetState extends State<FavoriteDescriptionWidget> {
  final TextEditingController descriptionController = TextEditingController();
  int textCount = 0;

  @override
  void initState() {
    super.initState();
    getFavoriteDescription();
    descriptionController.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    descriptionController.removeListener(_updateButtonColor);
    descriptionController.dispose();
    super.dispose();
  }

  void _updateButtonColor() {
    setState(() {
      textCount = descriptionController.text.length;
    });
  }

  Future getFavoriteDescription() async{
    setState(() {
      String? description = Provider.of<UserState>(context, listen: false).user!.favoriteDescription;
      if (description != null) {
        descriptionController.text = description;
      } else {
        descriptionController.text = '';
      }
      textCount = descriptionController.text.length;
    });
  }

  Future saveFavoriteDescription () async{
    bool isSaved = await Provider.of<UserState>(context, listen: false).saveFavoriteDescription(descriptionController.text);
    if(isSaved){
      await Provider.of<UserState>(context, listen: false).getUserInformation();
      Navigator.pushNamed(context, "/edit_profile");
    } else {
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
                  "画像の説明文を保存できませんでした。",
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BaseScreen(
      child: Stack(
        children: [
          Center(
            child: CustomContainer(
              decoration: BoxDecoration(
                color: AppColors.primaryWhite,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 122),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhite,
                      ),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: descriptionController,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            cursorColor: AppColors.primaryBlack,
                            style: TextStyle(color: AppColors.primaryBlack),
                            decoration: InputDecoration(
                              hintText: "6年前に行ったハワイの写真です。",
                              hintStyle: const TextStyle(
                                fontSize: 16
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsets.all(15),
                              fillColor: AppColors.primaryWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: bottomInset),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 20,
                        bottom: bottomInset!=0?bottomInset+10:20
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                            text: "$textCount/20文字", 
                            fontSize: 12, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1, 
                            letterSpacing: 1, 
                            color: AppColors.primaryBlack.withOpacity(0.5)
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          Center(
            child: CustomContainer(
              height: 94,
              decoration: BoxDecoration(
                // color: AppColors.secondaryGreen,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.primaryGray,
                    width: 2
                  )
                )
              ),
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    }, 
                                    icon: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: AppColors.primaryBlack,
                                    )
                                  ),
                                  CustomText(
                                    text: "この写真にコメントをしよう！",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    lineHeight: 1,
                                    letterSpacing: -1,
                                    color: AppColors.primaryBlack,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Container(
                                  width: 93,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryGreen,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      saveFavoriteDescription();
                                    },
                                    child: Center(
                                      child: Text(
                                        "保 存",
                                        style: TextStyle(
                                          color: AppColors.primaryWhite,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
