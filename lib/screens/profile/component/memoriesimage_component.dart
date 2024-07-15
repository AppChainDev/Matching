import 'dart:io';

import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MemoryImageWidget extends StatefulWidget{
  const MemoryImageWidget({
    super.key, this.memoriesImage
 });
 final String? memoriesImage;

  @override
  State<MemoryImageWidget> createState() => _MemoryImageWidgetState();
}

class _MemoryImageWidgetState extends State<MemoryImageWidget> {
  File? image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getImageFromGallery() async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File? croppedFile = await cropImage(File(pickedFile.path));
      setState(() {
        // ignore: unnecessary_null_comparison
        if (croppedFile != null) {
          image = croppedFile;
        }
      });
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

  // ignore: non_constant_identifier_names
  Widget MemoryImage(){
    if(image != null){
      return Container(
        width: 176,
        height: 162,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: FileImage(
              image!,
              scale: 1.0
            ),
            fit: BoxFit.cover
          )
        )
      );
    }else{
      if(widget.memoriesImage != null){
        return Container(
          width: 176,
          height: 162,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage("assets/images/${widget.memoriesImage}"),
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
            image: const DecorationImage(
              image: AssetImage("assets/images/memories_image.png"),
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
      padding: const EdgeInsets.only(top: 16, left: 20, right: 16, bottom: 40),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "あなたの思い出の1枚", 
            fontSize: 17, 
            fontWeight: FontWeight.normal, 
            lineHeight: 1.5, 
            letterSpacing: 1, 
            color: AppColors.primaryBlack
          ),
          CustomText(
            text: "価値観に共感してくれる人が見つかります", 
            fontSize: 12, 
            fontWeight: FontWeight.normal, 
            lineHeight: 1, 
            letterSpacing: 1, 
            color: AppColors.secondaryGray
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => getImageFromGallery(),
                    child: MemoryImage()
                  )
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/memories_description");
            },
            child: const MemoriesImageDescriptionItem()
          )
        ],
      ),
    );
  }
}

class MemoriesImageDescriptionItem extends StatelessWidget{
  const MemoriesImageDescriptionItem({
    super.key
 });

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 14, left: 10, right: 10, bottom: 14),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.secondaryGray,
        ),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.secondaryGreen,
                borderRadius: BorderRadius.circular(50)
              ),
              child: Icon(
                Icons.add,
                color: AppColors.primaryWhite,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            CustomText(
              text: "写真に対して一言追加してみよう", 
              fontSize: 14, 
              fontWeight: FontWeight.normal, 
              lineHeight: 1, 
              letterSpacing: -1, 
              color: AppColors.secondaryGray
            ),
            const SizedBox(
              width: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: AppColors.secondaryBlue,
                  size: 20,
                ),
                CustomText(
                  text: "100P", 
                  fontSize: 14, 
                  fontWeight: FontWeight.bold, 
                  lineHeight: 1, 
                  letterSpacing: 1, 
                  color: AppColors.secondaryBlue
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
