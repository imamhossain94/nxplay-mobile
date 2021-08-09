import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/models/single_video/single_video.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class PhotosCardWidget extends StatelessWidget {
  const PhotosCardWidget({
    Key key,
    @required this.video,
  }) : super(key: key);

  final SingleVideo video;

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);

    int length = video.photos.length;

    return Container(
      padding:EdgeInsets.only(bottom: 5),
      color: ThemesMode.isDarkMode ? AppColors.textBlack : AppColors.textWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 10, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Photos",
                  style: TextStyle(
                    fontSize: 18,
                    color: ThemesMode.isDarkMode
                        ? AppColors.textWhite
                        : AppColors.textBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Material(
                  child:InkWell(
                    child:Container(
                      alignment:Alignment.center,
                        width:50,
                        child: FaIcon(FontAwesomeIcons.longArrowAltRight)
                      ),
                    borderRadius: BorderRadius.circular(3),
                    onTap: () {
                      //onPressed();
                    },
                  )
                ), 
              ],
            ),
          ),
          length >= 4 ? fourPhotosCard(): twoPhotosCard(),
        ],
      ),
    );
  }

  String _photo(int i){
    String p = video.photos[i].substring(0, video.photos[i].length-4);
    String q = video.photos[i].substring(video.photos[i].length-4, video.photos[i].length);
    String r = '$p UX300 $q'.replaceAll(' ', '');
    return r;
  }

  Widget twoPhotosCard() {
    String photoUrl = DotEnv().env['PHOTO_URL'];
    String posterUrl = DotEnv().env['POSTER_URL'];
    double height = Responsive.screenWidth / 2 + Responsive.screenWidth / 6;
    double width = Responsive.screenWidth;

    return Container(
        color:
            ThemesMode.isDarkMode ? AppColors.textBlack : AppColors.textWhite,
        //padding: EdgeInsets.all(15),
        height: height,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            coverPhotosWidget('$posterUrl${video.poster}', height - 30,
                (width / 2) - (width / 10)),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                photosWidget('$photoUrl${_photo(0)}',
                    (height - 30) / 2 - 5, (width / 2)),
                SizedBox(
                  height: 10,
                ),
                photosWidget('$photoUrl${_photo(1)}',
                    (height - 30) / 2 - 5, (width / 2)),
              ],
            )
          ],
        ));
  }

  Widget fourPhotosCard() {
    String photoUrl = DotEnv().env['PHOTO_URL'];
    String posterUrl = DotEnv().env['POSTER_URL'];
    double height = Responsive.screenWidth / 2;
    double width = Responsive.screenWidth;

    return Container(
        color:
            ThemesMode.isDarkMode ? AppColors.textBlack : AppColors.textWhite,
        //padding: EdgeInsets.all(15),
        height: height,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            coverPhotosWidget('$posterUrl${video.poster}', height - 30,
                (width / 2) - (width / 5)),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                photosWidget('$photoUrl${_photo(0)}',
                    (height - 30) / 2 - 5, (width / 3.48)),
                SizedBox(
                  height: 10,
                ),
                photosWidget('$photoUrl${_photo(1)}',
                    (height - 30) / 2 - 5, (width / 3.48)),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                photosWidget('$photoUrl${_photo(2)}',
                    (height - 30) / 2 - 5, (width / 3.48)),
                SizedBox(
                  height: 10,
                ),
                photosWidget('$photoUrl${_photo(3)}',
                    (height - 30) / 2 - 5, (width / 3.48)),
              ],
            )
          ],
        ));
  }

  Widget coverPhotosWidget(String photo, double height, double width) {
    return Container(
        height: height,
        width: width,
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          shape: BoxShape.rectangle,
          image: new DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(photo)),
        ));
  }

  Widget photosWidget(String photo, double height, double width) {
    return Container(
        height: height,
        width: width,
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          shape: BoxShape.rectangle,
          image: new DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(photo)),
        ));
  }
}
