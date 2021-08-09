import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meedu_player/meedu_player.dart';
import 'package:nx_play/src/models/single_video/single_video.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget({Key key, @required this.video}) : super(key: key);
  final SingleVideo video;
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState(video,);
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  SingleVideo video;
  bool isPopUp = true;

  _VideoPlayerWidgetState(this.video,);

  final _meeduPlayerController = MeeduPlayerController(
    controlsStyle: ControlsStyle.secondary,
    pipEnabled: getVideoPictureInPicture(),
    showPipButton: getVideoPictureInPicture(),
    colorTheme: AppColors.textBlue,
  );

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _meeduPlayerController.dispose();
    super.dispose();
  }

  _init() {
    String videoUrl = DotEnv().env['VIDEO_URL'];
    _meeduPlayerController.setDataSource(
      DataSource(
        type: DataSourceType.network,
        //source: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4",
        source: '$videoUrl${video.video}',
      ),
      autoplay: getVideoAutoPlay(),
      looping: getVideoLooping(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    //Orientation orientation = Responsive.orientation;
    // double height = Responsive.orientation == Orientation.landscape?Responsive.screenHeight:(Responsive.screenWidth/3.55)+(Responsive.screenWidth/3.55);
    // double width = Responsive.screenWidth;
    // SystemChrome.setEnabledSystemUIOverlays([Responsive.orientation == Orientation.portrait?SystemUiOverlay.bottom:SystemUiOverlay.values]);

    return
      Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: Responsive.orientation == Orientation.portrait?16/9: MediaQuery.of(context).devicePixelRatio-0.405,
            child: MeeduVideoPlayer(
              controller: _meeduPlayerController,
              header: (ctx, controller, responsive) {
                final double fontSize = Responsive.orientation == Orientation.portrait?responsive.ip(4):responsive.ip(3);
                return header(fontSize);
              },
            ),
          )
        ]
      );
    //   Container(
    //   color: Colors.black,
    //   height:height,
    //   width: width,
    //   child: AspectRatio(
    //     aspectRatio: 16/9,//Responsive.orientation == Orientation.portrait?16/9: MediaQuery.of(context).devicePixelRatio-0.405,
    //     child: MeeduVideoPlayer(
    //       controller: _meeduPlayerController,
    //       header: (ctx, controller, responsive) {
    //         final double fontSize = responsive.ip(4);
    //         return header(fontSize);
    //       },
    //     ),
    //   ),
    // );
  }

  Widget header(double fontSize) {
    return Container(
      padding: EdgeInsets.only(left: 0, top:5, bottom: 5),
      color: Colors.black12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            color:Colors.transparent,
            child:InkWell(
              child:Container(
                alignment:Alignment.center,
                  width:50,
                  child: FaIcon(FontAwesomeIcons.chevronLeft, color: Colors.white, size:18)
                ),
              borderRadius: BorderRadius.circular(3),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ), 
          SizedBox(
            width: 0,
          ),
          Text(
            video.title,
            style: TextStyle(
                color: Colors.white,
                fontSize: fontSize > 18 ? 18 : fontSize,
                fontWeight: FontWeight.bold),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
