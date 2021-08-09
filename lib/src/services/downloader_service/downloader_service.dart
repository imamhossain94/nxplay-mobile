import 'dart:async';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class DownloaderService {
  String taskId;
  String videoUrl;

  DownloaderService(){
    if(videoUrl==null){
      videoUrl = DotEnv().env['VIDEO_URL'];
    }
  }

  Future<void> downloadVideo(String downloadUrl, String title) async {
    final directory = await getApplicationDocumentsDirectory();
    var pathDirectory = directory.path + title;
    final savedDirectory = Directory(directory.path + title);
    await savedDirectory.create(recursive: true).then((value) async {
      taskId = await FlutterDownloader.enqueue(
        url: "$videoUrl$downloadUrl",
        //url: 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4',
        fileName: title,
        savedDir: pathDirectory,
        showNotification: true,
        openFileFromNotification: true,
      );
      print(taskId);
    });
  }
}

