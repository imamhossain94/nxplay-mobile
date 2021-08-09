import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class PasswordInput extends StatefulWidget {
  PasswordInput({
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
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isShown = false;

  @override
  void initState() {
    super.initState();
    isShown = false;
  }

   // final TextEditingController control = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);

    Icon passIcon = isShown
        ? Icon(FontAwesomeIcons.eyeSlash, color: Colors.white, size: responsiveHeight(isPotrait()?18:30),)
        : Icon(FontAwesomeIcons.eye, color: Colors.white, size: responsiveHeight(isPotrait()?18:30),);

    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: responsiveHeight(isPotrait()?55:90),
        //width: responsiveWidth(1),
        decoration: BoxDecoration(
          color: ThemesMode.isDarkMode ? AppColors.secondaryDark : AppColors.textBlue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  widget.icon,
                  size: responsiveHeight(isPotrait()?18:30),
                  color: AppColors.textWhite,
                ),
              ),
              suffixIcon: Container(
                height: responsiveHeight(isPotrait()?55:90),
                width:responsiveHeight(isPotrait()?55:90),
                child: Stack(
                  children: [
                    Center(child: passIcon),
                    Positioned.fill(
                      child: new Material(
                          color: Colors.transparent,
                          child: new InkWell(
                           // borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              setState(() {
                                if (isShown) {
                                  isShown = false;
                                } else {
                                  isShown = true;
                                }
                              });
                            },
                          )
                        )
                    ),
                  ],
                ),
              ),
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontSize: responsiveText(isPotrait()?18:30),
                color:AppColors.textWhite
              ),
            ),
            obscureText: !isShown,
            style: TextStyle(
              fontSize: responsiveText(isPotrait()?18:30),
              color:AppColors.textWhite
            ),
            keyboardType: widget.inputType,
            textInputAction: widget.inputAction,
          ),
        ),
      ),
    );
  }
}
