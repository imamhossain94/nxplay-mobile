import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nx_play/src/services/notification_service/fcm_notification_service.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/router.dart' as router;
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/themes.dart';
import 'package:nx_play/src/utils/themes_mode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nx_play/src/utils/provider.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

Future<void> main() async {
  await DotEnv().load('.env');
  await firebase_core.Firebase.initializeApp();
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  firebaseMessaging.subscribeToTopic('nxPlay');
  await FlutterDownloader.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  SharedPref().init();
  prefs.then((value) {
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (BuildContext context) {
          String theme = value.getString(AppConstants.appTheme);
          if (theme == null ||
              theme == "" ||
              theme == AppConstants.systemDefault) {
            value.setString(AppConstants.appTheme, AppConstants.systemDefault);
            return ThemeNotifier(ThemeMode.system);
          }
          return ThemeNotifier(
              theme == AppConstants.dark ? ThemeMode.dark : ThemeMode.light);
        },
        child: NxPlay(),
      ),
    );
  });
}

// Future<void> initPluginTest() async {
//   // Platform messages may fail, so we use a try/catch PlatformException.
//   try {
//     // As in Pusher Beams Get Started
//     await PusherBeams.addDeviceInterest('hello');
//
//     // For debug purposes on Debug Console
//     await PusherBeams.addDeviceInterest('debug-hello');
//
//     final interests = await PusherBeams.getDeviceInterests();
//
//     // Result example [hello, debug-hello, ...]
//     print(interests);
//   } on PlatformException {
//     print("PlatformException D:");
//   }
// }

class NxPlay extends StatefulWidget {

  @override
  _NxPlayState createState() => _NxPlayState();
}

class _NxPlayState extends State<NxPlay> {

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().lightTheme(),
      darkTheme: AppTheme().darkTheme(),
      themeMode: themeNotifier.getThemeMode(),
      initialRoute: AppConstants.rSplashScreen,
      onGenerateRoute: router.generateRoute,
      builder: EasyLoading.init(),
    );
  }
}

// void fcmSubscribe() {
//   firebaseMessaging.subscribeToTopic('nxPlay');
// }
//
// void fcmUnSubscribe() {
//   firebaseMessaging.unsubscribeFromTopic('nxPlay');
// }



