import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/icon_button.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// ignore: must_be_immutable
class DownloadTile extends StatelessWidget {
  final Map item;
  final VoidCallback onPlay, onPause, onCancel, onRetry, onDelete;
  DownloadTile({Key key, this.item, this.onPlay, this.onPause, this.onCancel, this.onRetry, this.onDelete}):super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    double height = Responsive.screenWidth / 11 + Responsive.screenWidth / 11;
    double width = Responsive.screenWidth;

    int progress = item['progress'];
    String filename = item['filename'];
    String savedDirectory = item['savedDirectory'];
    DownloadTaskStatus downloadTaskStatus = item['status'];

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
      child: Stack(
        children: [
          Card(
            color: ThemesMode.isDarkMode?AppColors.textBlack:AppColors.textWhite,
            elevation: 2,
            child: Container(
              height: height,
              width: Responsive.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: (width / 4) - (width / 10),
                    height: height,
                    margin: EdgeInsets.fromLTRB(8, 8, 15, 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ThemesMode.isDarkMode?AppColors.backgroundDark:AppColors.backgroundLight,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      shape: BoxShape.rectangle,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.solidFileVideo,
                      size: 36,
                      color: ThemesMode.isDarkMode?AppColors.textYellow:AppColors.textBlue,
                    ),
                  ),

                  Container(
                    height: height,
                    width: Responsive.screenWidth-109,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buttonControl(filename, downloadTaskStatus),
                        downloadTaskStatus == DownloadTaskStatus.complete?
                        Flexible(flex:1,child: Text(savedDirectory, maxLines:1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, )))
                        :downloadControl(progress),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget downloadControl(int progressValue){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LinearPercentIndicator(
          width: Responsive.screenWidth-123,
          animation: true,
          lineHeight: 15.0,
          animationDuration: 0,
          percent: progressValue.toDouble()/100,
          center: Text("$progressValue%"),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: ThemesMode.isDarkMode?AppColors.textYellow:AppColors.textBlue,
        ),


      ],
    );
  }

  Widget buttonControl(String filename, DownloadTaskStatus downloadTaskStatus){
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            filename,
            maxLines:1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold
            ),
          ),
          Spacer(),

          downloadTaskStatus == DownloadTaskStatus.canceled?
          IconButtonWidget(icon: FontAwesomeIcons.redoAlt, iconSize: 14, onPressed: (){
            onRetry();
          })
          :downloadTaskStatus == DownloadTaskStatus.failed?
          IconButtonWidget(icon: FontAwesomeIcons.redoAlt, iconSize: 14, onPressed: (){
            onRetry();
          })
          :downloadTaskStatus == DownloadTaskStatus.paused?
          Row(
            children: [
              IconButtonWidget(icon: FontAwesomeIcons.play, iconSize: 14, onPressed: (){
                onPlay();
              }),
              IconButtonWidget(icon: FontAwesomeIcons.times, iconSize: 16, onPressed: (){
                onCancel();
              })
            ],
          )
          :downloadTaskStatus == DownloadTaskStatus.running?
          Row(
            children: [
              IconButtonWidget(icon: FontAwesomeIcons.pause, iconSize: 14, onPressed: (){
                onPlay();
              }),
              IconButtonWidget(icon: FontAwesomeIcons.times, iconSize: 16, onPressed: (){
                onCancel();
              })
            ],
          )
          :downloadTaskStatus == DownloadTaskStatus.complete?
          IconButtonWidget(icon: FontAwesomeIcons.trash, iconSize: 14, onPressed: (){
            onDelete();
          })
          :SizedBox(width: 0,),
        ],
    );
  }
}
