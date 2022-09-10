import 'package:flutter/material.dart';
import 'package:instaclone/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;

  const ResponsiveLayout({Key? key, required this.mobileScreenLayout, required this.webScreenLayout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth > webScreenSize){
          //Web Screen Layout
          return webScreenLayout;
        }

        // Mobile Screen Layout
        return mobileScreenLayout;
      } 
      
      );
  }
}