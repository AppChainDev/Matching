import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  const BaseScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context){
    if(kIsWeb){
      return Scaffold(
        body: Center(
          child: SizedBox(
            width: 375,
            height: 812,
            child: Center(
              child: SingleChildScrollView(
                child:child
              )
            ),
          ),
        ),
      );
    }
    if (Platform.isAndroid) {   
      return Scaffold(
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // width: 375,
            // height: 812,
            child: Center(
              child: SingleChildScrollView(
                child:child
              )
            ),
          ),
        ),
      );
    }else if(Platform.isIOS){
      return Scaffold(
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // width: 375,
            // height: 812,
            child: Center(
              child: SingleChildScrollView(
                child:child
              )
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: SizedBox(
            width: 375,
            height: 812,
            child: Center(
              child: SingleChildScrollView(
                child:child
              )
            ),
          ),
        ),
      );
    }
  }
}