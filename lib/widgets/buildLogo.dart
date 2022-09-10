import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instaclone/utils/colors.dart';

class BuildLogo extends StatelessWidget {
  const BuildLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/ic_instagram.svg',
      color: primaryColor,
      height: 64,
    );
  }
}
