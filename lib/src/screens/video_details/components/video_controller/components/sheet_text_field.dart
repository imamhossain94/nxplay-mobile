import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class SheetTextField extends StatelessWidget {
  final String hint;
  final VoidCallback onPressed;
  final TextEditingController controller;
  final bool autoFocus;
  const SheetTextField({Key key, @required this.hint, @required this.autoFocus, @required this.onPressed, @required this.controller}):super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);

    return Container(
      width: Responsive.screenWidth,
      decoration: BoxDecoration(
        color: ThemesMode.isDarkMode?AppColors.textBlack:AppColors.textWhite,
      ),
      child: Stack(
        children: [
          Container(
            width: Responsive.screenWidth,
            child: TextField(
              minLines: 1,
              maxLines: 10,
              autocorrect: false,
              controller: controller,
              autofocus: autoFocus,
              decoration: InputDecoration(
                hintText: hint,
                contentPadding: EdgeInsets.only(left: 20, right: 75),
                filled: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 15,
            bottom: 0,
            child: Stack(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(22, 5, 22, 5),
                    alignment: Alignment.center,
                    child: FaIcon(FontAwesomeIcons.paperPlane,
                        size: responsiveText(16),
                        color: ThemesMode.isDarkMode
                            ? AppColors.textYellow
                            : AppColors.textBlue)),
                Positioned.fill(
                    child: new Material(
                        color: Colors.transparent,
                        child: new InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            onPressed();
                          },
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
