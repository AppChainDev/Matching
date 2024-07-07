import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoPicker extends StatelessWidget {

  final List<String> items;
  final Function(int) onSelectedItemChanged;
  final String text;

  const CustomCupertinoPicker({super.key, required this.items, required this.onSelectedItemChanged, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 54,
          decoration: BoxDecoration(
            color: AppColors.secondaryGreen,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
          ),
          child: Stack(
            children: [
              Center(
                child: CustomText(
                  text: text, 
                  fontSize: 17, 
                  fontWeight: FontWeight.bold, 
                  lineHeight: 1, 
                  letterSpacing: 1.5, 
                  color: AppColors.primaryWhite
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        width: 93,
                        height: 35,
                        decoration: BoxDecoration(
                          color: AppColors.primaryWhite,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              "完 了",
                              style: TextStyle(
                                color: AppColors.secondaryGreen,
                                fontWeight: FontWeight.normal,
                                fontSize: 13
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryWhite
          ),
          height: MediaQuery.of(context).copyWith().size.height / 4,
          child: CupertinoPicker(
            itemExtent: 40.0, // Height of each item in the picker
            onSelectedItemChanged: onSelectedItemChanged,
            children: items.map((item) => Center(
              child: Text(
                item
              ),
            )).toList()
          )
        ),
      ],
    );
  }
}
