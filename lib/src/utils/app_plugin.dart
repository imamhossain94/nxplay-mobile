import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:nx_play/src/utils/app_color.dart';

class AppPlugin {
  void showMessage(BuildContext context, String text) {
    var alert = new AlertDialog(content: new Text(text), actions: <Widget>[
      new FlatButton(
          child: const Text("Ok"),
          onPressed: () {
            Navigator.pop(context);
          })
    ]);
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  void flushInfo(BuildContext context, String message){
    var _isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Flushbar(
      message:  message,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      borderRadius: 8,
      backgroundColor: _isDarkMode?AppColors.secondaryDark:AppColors.textBlue,
      icon: Icon(
      Icons.info,
      size: 28.0,
      color: Colors.white,
      ),
      duration:  Duration(seconds: 3),              
    )..show(context);
  }

  

}
