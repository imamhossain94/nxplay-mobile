import 'package:flutter/material.dart';
import 'package:nx_play/src/components/bottom_navigation_bar.dart';
import 'package:nx_play/src/screens/browse/components/body.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Downloads'), elevation: 0,),
        body: Body(),
        bottomNavigationBar: BottomNavBar(selectedMenu: AppConstants.rBrowseScreen,),
      ),
    );
  }
}