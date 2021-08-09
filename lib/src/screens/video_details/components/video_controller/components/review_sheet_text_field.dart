import 'package:flutter/material.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class ReviewSheetTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final int maxLine;
  final bool isPassword;
  const ReviewSheetTextField({Key key, @required this.hint, @required this.controller, @required this.maxLine, @required this.isPassword}):super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    return Container(
      width: Responsive.screenWidth,
      margin: EdgeInsets.fromLTRB(15, 7.5, 15, 7.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ThemesMode.isDarkMode?Colors.grey[900].withOpacity(0.9):Colors.grey[300].withOpacity(0.5),
      ),
      child: TextField(
        minLines: 1,
        maxLines: maxLine,
        autocorrect: false,
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 20, right: 20)
        ),
      ),
    );
  }
}
