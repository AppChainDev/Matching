import 'dart:io';

import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MainPhoto extends StatefulWidget{
  const MainPhoto({
    super.key, required this.id, required this.avatarList
 });

 final int id;
 final List<String> avatarList;

  @override
  State<MainPhoto> createState() => _MainPhotoState();
}

class _MainPhotoState extends State<MainPhoto> {
  late List<File?> image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    setState(() {
      image = List<File?>.filled(5, null);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getImageFromGallery(int index) async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File? croppedFile = await cropImage(File(pickedFile.path));
      setState(() {
        // ignore: unnecessary_null_comparison
        if (croppedFile != null) {
          image[index] = croppedFile;
        }
      });
      if(croppedFile != null){
        await Provider.of<UserState>(context, listen: false).saveAvatar(croppedFile, index);
      }
    }
  }
  Future<File?> cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
      ),
      IOSUiSettings(
        title: 'Cropper',
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
      ),
      ],
    );
    if(croppedFile != null){
      return File(croppedFile.path);
    }else{
      return null;
    }
  }

  Widget mainAvatar(){
    if(image.isNotEmpty && image[0]!=null){
      return Container(
        width: 176,
        height: 162,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: FileImage(
              image[0]!,
              scale: 1.0
            ),
            fit: BoxFit.cover
          )
        )
      );
    }else{
      return Container(
        width: 176,
        height: 162,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage("${dotenv.get('BASE_URL')}/img/${widget.avatarList[0]}"),
            fit: BoxFit.cover
          )
        )
      );
    }
  }

  Widget addImage(int index){
    if(image.isNotEmpty && image[index]!=null){
      return Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: FileImage(
              image[index]!,
              scale: 1.0
            ),
            fit: BoxFit.cover
          )
        )
      );
    }else{
      if(widget.avatarList[index] != ""){  
        return Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage("${dotenv.get('BASE_URL')}/img/${widget.avatarList[index]}"),
              fit: BoxFit.cover,
            )
          )
        );
      }else{
        return Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage("assets/images/addimage_back.png"),
              fit: BoxFit.cover
            )
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 94, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryWhite,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left:30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 176,
              height: 162,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  mainAvatar(),
                  Container(
                    width: 154,
                    height: 30,
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryGreen,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        getImageFromGallery(0);
                      },
                      child: Center(
                        child: CustomText(
                          text: "メイン写真を編集", 
                          fontSize: 10, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: -1, 
                          color: AppColors.primaryWhite
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) => 
                GestureDetector(
                  onTap: () => getImageFromGallery(index),
                  child: addImage(index)
                )
              )
            )
            
          ],
        ),
      )
    );
  }
}