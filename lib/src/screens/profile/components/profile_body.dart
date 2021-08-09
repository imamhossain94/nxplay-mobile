import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/screens/profile/components/header.dart';
import 'package:nx_play/src/screens/profile/components/edit_profile/profile_card.dart';
import 'package:nx_play/src/screens/profile/components/settings/settings.dart';
import 'package:nx_play/src/screens/profile/components/settings/title_bar.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/services/social/facebook_auth_service.dart';
import 'package:nx_play/src/services/social/google_auth_service.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    ThemesMode().init(context);
    return ListView(
      children: [
        HeaderWidget(),
        ProfileCardWidget(),
        TitleBarWidget(
            title: "Settings", icon: FontAwesomeIcons.cogs, onPressed: null),
        Divider(height: 1, color: Colors.grey[600]),
        SettingWidget(),
        Divider(height: 1, color: Colors.grey[600]),
        TitleBarWidget(
            title: "Sign Out",
            icon: FontAwesomeIcons.signOutAlt,
            onPressed: () {
              _signOut(context);
            }),
      ],
    );
  }

  void _signOut(BuildContext context) {
    FacebookAuthService facebookAuthService = new FacebookAuthService();
    facebookAuthService.facebookSignOut();
    GoogleAuthService googleAuthService = new GoogleAuthService();
    googleAuthService.googleSignOut();
    removeNxPlayUser();
    Navigator.pushReplacementNamed(context, AppConstants.rHomeScreen);
  }
}
