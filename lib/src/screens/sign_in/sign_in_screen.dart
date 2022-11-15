import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nx_play/src/models/profile/update_profile_response.dart';
import 'package:nx_play/src/screens/sign_in/components/icon_button.dart';
import 'package:nx_play/src/screens/sign_in/components/password_input.dart';
import 'package:nx_play/src/screens/sign_in/components/text_button.dart';
import 'package:nx_play/src/screens/sign_in/components/text_input.dart';
import 'package:nx_play/src/services/nx_play/nx_play_auth_service.dart';
import 'package:nx_play/src/services/nx_play/nx_play_log_in.dart';
import 'package:nx_play/src/services/social/facebook_auth_service.dart';
import 'package:nx_play/src/services/social/github_auth_service.dart';
import 'package:nx_play/src/services/social/google_auth_service.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/app_plugin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AppPlugin _appPlugin;
  final Map<String, String> params = {};

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async => await Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    ThemesMode().init(context);
    _appPlugin = AppPlugin();
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text(
                AppConstants.signIn.toUpperCase(),
                style: TextStyle(
                  fontSize: responsiveText(24),
                  fontWeight: FontWeight.bold,
                  color: ThemesMode.isDarkMode
                      ? AppColors.textWhite
                      : AppColors.textBlue,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextInputField(
                          controller: emailController,
                          icon: FontAwesomeIcons.at,
                          hint: AppConstants.email,
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                        ),
                        PasswordInput(
                          controller: passwordController,
                          icon: FontAwesomeIcons.lock,
                          hint: AppConstants.password,
                          inputAction: TextInputAction.done,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(AppConstants.doNotHaveAccount,style: TextStyle(fontSize: responsiveText(14)),),
                            SizedBox(
                              width: responsiveWidth(.5),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppConstants.rSignUpScreen);
                                },
                                child: Text(
                                  '${AppConstants.signUp}!',
                                  style: TextStyle(
                                    fontSize: responsiveText(14),
                                    color: ThemesMode.isDarkMode
                                        ? AppColors.textYellow
                                        : AppColors.textRed),
                                ))
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppConstants.rResetPassword);
                          },
                          child: Text(
                            '${AppConstants.forgotPassword}!',
                            style: TextStyle(
                              fontSize: responsiveText(14),
                              color: ThemesMode.isDarkMode
                                  ? AppColors.textYellow
                                  : AppColors.textRed),
                          )
                        ),
                        SizedBox(height: responsiveWidth(.5)),
                      ]
                    ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                RoundedIconButton(
                  icon: FontAwesomeIcons.facebookF,
                  color: AppColors.textWhite,
                  onPressed: () async {
                    //---------facebook-----------
                    facebook(context);
                  },
                ),
                SizedBox(width: responsiveWidth(10)),
                RoundedIconButton(
                  icon: FontAwesomeIcons.google,
                  color: AppColors.textWhite,
                  onPressed: () async {
                    //-------google-------
                    google(context);
                  },
                ),
                SizedBox(width: responsiveWidth(10)),
                RoundedIconButton(
                  icon: FontAwesomeIcons.githubAlt,
                  color: AppColors.textWhite,
                  onPressed: () async {
                    //-------github--------
                    github(context);
                  },
                ),
                Spacer(),
                RoundedTextButton(
                  buttonName: AppConstants.signIn.toUpperCase(),
                  onPressed: () async {
                    //-------nxplay--------//
                    nxPlay(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //------------------action---made---hare------------------//
  void facebook(BuildContext context) async {
    try{
      showLoading();
      FacebookAuthService facebookAuthService = new FacebookAuthService();
      if (await facebookAuthService.facebookSignIn() == true) {
        params.clear();
        print(FirebaseMessaging().getToken());
        params['fcm_token'] = await FirebaseMessaging().getToken();
        UpdateProfileResponse updateProfileResponse
        = await NxPlayAuthServices().updateUserProfile(params);
        EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, AppConstants.rHomeScreen);
      } else {
        EasyLoading.dismiss();
        _appPlugin.flushInfo(context, facebookAuthService.error);
      }
    }catch (e){
      EasyLoading.dismiss();
      _appPlugin.flushInfo(context, e);
    }
  }

  void google(BuildContext context) async {
    try{
      showLoading();
      GoogleAuthService googleAuthService = new GoogleAuthService();
      if (await googleAuthService.googleSignIn() == true) {
        params.clear();
        print(FirebaseMessaging().getToken());
        params['fcm_token'] = await FirebaseMessaging().getToken();
        UpdateProfileResponse updateProfileResponse
        = await NxPlayAuthServices().updateUserProfile(params);
        EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, AppConstants.rHomeScreen);
      } else {
        EasyLoading.dismiss();
        _appPlugin.flushInfo(context, googleAuthService.error);
      }
    }catch (e){
      EasyLoading.dismiss();
      _appPlugin.flushInfo(context, e);
    }
  }

  void github(BuildContext context) async {
    // try{
    //   showLoading();
    //   GithubAuthService githubAuthService
    //   = new GithubAuthService(context: context);
    //   if (await githubAuthService.githubSignIn() == true) {
    //     params.clear();
    //     print(FirebaseMessaging().getToken());
    //     params['fcm_token'] = await FirebaseMessaging().getToken();
    //     UpdateProfileResponse updateProfileResponse
    //     = await NxPlayAuthServices().updateUserProfile(params);
    //     EasyLoading.dismiss();
    //     Navigator.pushReplacementNamed(context, AppConstants.rHomeScreen);
    //   } else {
    //     EasyLoading.dismiss();
    //     _appPlugin.flushInfo(context, githubAuthService.error);
    //   }
    // }catch (e){
    //   EasyLoading.dismiss();
    //   _appPlugin.flushInfo(context, e);
    // }
  }

  void nxPlay(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (email.isEmpty || password.isEmpty) {
      _appPlugin.flushInfo(context,
          'Enter email and password to sign in or continue using facebbok, google or github profile.');
    } else if (!emailValid) {
      _appPlugin.flushInfo(context, 'Invalid email address!');
    } else if (password.length < 8) {
      _appPlugin.flushInfo(
          context, 'The password must be at last 8 character long.');
    } else {
      showLoading();
      NxPlayLogInService nxPlayLogInService
      = new NxPlayLogInService(email: email, password: password);
      if (await nxPlayLogInService.nxPlayLogIn() == true) {
        params.clear();
        print(FirebaseMessaging().getToken());
        params['fcm_token'] = await FirebaseMessaging().getToken();
        UpdateProfileResponse updateProfileResponse
        = await NxPlayAuthServices().updateUserProfile(params);
        EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, AppConstants.rHomeScreen);
      } else {
        EasyLoading.dismiss();
        _appPlugin.flushInfo(context, nxPlayLogInService.error);
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
