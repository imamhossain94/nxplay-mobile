import 'package:flutter/material.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key key,
    @required this.icon,
    @required this.hint,
    this.inputType,
    this.inputAction,
    this.controller,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: responsiveHeight(isPotrait()?55:90),
        //width: responsiveWidth(1),
        decoration: BoxDecoration(
          color: ThemesMode.isDarkMode?AppColors.secondaryDark:AppColors.textBlue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(icon, size: responsiveHeight(isPotrait()?18:30),color: AppColors.textWhite,),
              ),
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: responsiveText(isPotrait()?18:30),
                color:AppColors.textWhite
              ),
            ),
            style: TextStyle(
              fontSize: responsiveText(isPotrait()?18:30),
              color:AppColors.textWhite
            ),
            keyboardType: inputType,
            textInputAction: inputAction,
          ),
        ),
      ),
    );
  }
}
