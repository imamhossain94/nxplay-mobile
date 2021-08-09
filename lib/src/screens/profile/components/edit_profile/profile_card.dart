import 'package:flutter/material.dart';
import 'package:nx_play/src/screens/profile/components/edit_profile/load_avatar.dart';
import 'package:nx_play/src/screens/profile/components/edit_profile_sheet.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class ProfileCardWidget extends StatefulWidget {
  const ProfileCardWidget({Key key,}): super(key: key);

  @override
  _ProfileCardWidgetState createState() => _ProfileCardWidgetState();
}

class _ProfileCardWidgetState extends State<ProfileCardWidget> {

  bool _refresh = false;

  void displayBottomSheet(BuildContext context) {
    Scaffold.of(context).showBottomSheet<void>(
      (BuildContext context) => EditProfileSheet(onPressed: (){
        setState(() {
          Navigator.pop(context);
          _refresh==true?false:true;
        });
      },),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor:Colors.transparent,
    );

  }

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      //height: 80,
      child: Column(
        children: [
          profileItem(context),
        ],
      ),
    );
  }

  Widget profileItem(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        LoadAvatarWidget(avatar: getUserAvatar(),),
        SizedBox(
          width: 25,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              getUserName(),
              style: TextStyle(
                fontSize: 20,
                color: ThemesMode.isDarkMode
                    ? AppColors.textWhite
                    : AppColors.textBlack,
                //fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              getUserEmail(),
              style: TextStyle(
                fontSize: 14,
                color: ThemesMode.isDarkMode ? Colors.white54 : Colors.black54,
                //fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            textButton(context),
          ],
        ),
      ],
    );
  }

  Widget textButton(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            decoration: BoxDecoration(
              color: ThemesMode.isDarkMode ? Colors.black45 : Colors.grey[300],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "Edit Profile",
              style: TextStyle(fontSize: 12),
            )),
        Positioned.fill(
          child: Material(
              color: Colors.transparent,
              child: new InkWell(
                highlightColor: ThemesMode.isDarkMode
                    ? Colors.black45.withOpacity(.5)
                    : Colors.grey[300].withOpacity(.5),
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  displayBottomSheet(context);
                },
              )),
        ),
      ],
    );
  }
}
