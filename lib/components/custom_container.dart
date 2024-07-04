import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomContainer extends StatelessWidget {
  final double? height;
  // ignore: prefer_typing_uninitialized_variables
  final  transform;
  final bool? isAutoHeight;
  final double? width;
  final Widget? child;
  final BoxDecoration? decoration;

  const CustomContainer({super.key, this.height, this.width, this.child, this.decoration, this.isAutoHeight=true, this.transform,});

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: transform,
      height: height?? (kIsWeb?812:((Platform.isAndroid || Platform.isIOS)?MediaQuery.of(context).size.height:812)),
      width: width ?? (kIsWeb?375:((Platform.isAndroid || Platform.isIOS)?MediaQuery.of(context).size.height:375)),
      decoration: decoration,
      child: child?? const SizedBox(),
    );
  }
}
