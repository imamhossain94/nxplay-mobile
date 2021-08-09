import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nx_play/src/screens/forgot_password/components/text_button.dart';
import 'package:nx_play/src/screens/sign_in/components/text_input.dart';
import 'package:nx_play/src/services/auth_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/app_plugin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  AuthServices _authServices;
  AppPlugin _appPlugin;
  bool _isLinkSent = false;

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    ThemesMode().init(context);

    _authServices = AuthServices();
    _appPlugin = AppPlugin();
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
            color: ThemesMode.isDarkMode ? AppColors.textWhite : AppColors.textBlue),
        elevation: 0,
        title: Text(
          AppConstants.resetPassword.toUpperCase(),
          style: TextStyle(
              color: ThemesMode.isDarkMode ? AppColors.textWhite : AppColors.textBlue),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                    child: _isLinkSent ? _passwordSent() : _forgotPassword()),
              ),
            ),
            RoundedButton(
              buttonName: AppConstants.sendPasswordResetLink,
              onPressed: () async {
                //---------------PostRequest-------------
                if (_isLinkSent == false) {
                  sendPasswordLink(context);
                } else {}
              },
            ),
          ],
        ),
      ),
    );
  }

  //------------------wigets---made---hare------------------//
  Widget _forgotPassword() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.fromLTRB(0, 100, 0, 5),
            child: Text(
              AppConstants.enterYourEmail,
              style: TextStyle(
                fontSize: 18.0,
                color: ThemesMode.isDarkMode ? AppColors.textWhite : AppColors.textBlue,
              ),
            ),
          ),
          TextInputField(
            controller: emailController,
            icon: FontAwesomeIcons.at,
            hint: AppConstants.email,
            inputType: TextInputType.emailAddress,
            inputAction: TextInputAction.next,
          ),
        ]);
  }

  Widget _passwordSent() {
    return Center(
      child:Text('Password reset link has been sent. Please check your email with in 60 minutes.'),
    );
  }

  //------------------action---made---hare------------------//

  void sendPasswordLink(BuildContext context) async {
    String email = emailController.text;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (email.isEmpty) {
      _appPlugin.flushInfo(context, 'First enter your email address.');
    } else if (!emailValid) {
      _appPlugin.flushInfo(context, 'Invalid email address!');
    } else {
      showLoading();
      bool isSent = await _authServices.forgotPassword(email);
      EasyLoading.dismiss();
      if (isSent == true) {
        EasyLoading.showSuccess("Mail send successfully");
        setState(() async {
          _isLinkSent = true;
        });
      } else {
        EasyLoading.showError("Please try again later!");
      }
    }
  }

  Future<void> showLoading() async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
  }

  
}
