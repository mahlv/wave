import 'package:soundtt/constants/assets_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.wavyLogo,
        // ignore: deprecated_member_use
        height: 30,
      ),
centerTitle: true,
    );
  }


  static List<Widget> bottomTabBarPages = [
    Text('Feed Screen'),
    Text('Search Screen'),
    Text('Notification Screen'),
  ];
}

