import 'package:flutter/material.dart';
import 'package:nx_play/src/components/bottom_navigation_bar.dart';
import 'package:nx_play/src/screens/profile/components/profile_body.dart';
import 'package:nx_play/src/utils/constant.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileBody(),
      bottomNavigationBar: BottomNavBar(
        selectedMenu: AppConstants.rProfileScreen,
      ),
    );
  }
}
