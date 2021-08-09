import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:nx_play/src/screens/browse/components/download_tile.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ReceivePort receivePort = ReceivePort();
  List<Map> downloadData = [];
  bool refresh = false;

  @override
  void initState() {
    super.initState();
    task();
    bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    unbindBackgroundIsolate();
    super.dispose();
  }

  void bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(receivePort.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      unbindBackgroundIsolate();
      bindBackgroundIsolate();
      return;
    }
    receivePort.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      var task = downloadData?.where((element) => element['id'] == id);
      task.forEach((element) {
        element['progress'] = progress;
        element['status'] = status;
      });
      setState(() {});
    });
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  Future task() async {
    List<DownloadTask> getTasks = await FlutterDownloader.loadTasks();
    getTasks.forEach((task) {
      Map item = Map();
      item['status'] = task.status;
      item['progress'] = task.progress;
      item['taskId'] = task.taskId;
      item['filename'] = task.filename;
      item['savedDirectory'] = task.savedDir;
      downloadData.add(item);
    });
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemesMode.isDarkMode
            ? AppColors.primaryDark
            : AppColors.backgroundLight,
        body:
        downloadData.length !=0?
        Container(
          child: ListView.builder(
            itemCount: downloadData.length,
            itemBuilder: (BuildContext context, int i) {
              return DownloadTile(
                key: UniqueKey(),
                item: downloadData[i],
                onPlay: (){
                  // _scaffoldKey.currentState.setState(() {
                  //   FlutterDownloader.pause(taskId: downloadData[i]['taskId']);
                  // });
                },
                onPause: (){
                  FlutterDownloader.resume(taskId: downloadData[i]['taskId']).then((newTaskID) =>
                      changeTaskID(downloadData[i]['taskId'], newTaskID),
                  );
                },
                onCancel: (){
                  FlutterDownloader.cancel(taskId: downloadData[i]['taskId']);
                  // _scaffoldKey.currentState.setState(() {
                  //   refresh = refresh == false ? true : false;
                  // });
                },
                onRetry: (){
                  FlutterDownloader.retry(taskId: downloadData[i]['taskId']).then((newTaskID) =>
                    changeTaskID(downloadData[i]['taskId'], newTaskID),
                  );
                },
                onDelete: (){
                  //downloadData.removeAt(i);
                  FlutterDownloader.remove(taskId: downloadData[i]['taskId'], shouldDeleteContent: true);
                  // _scaffoldKey.currentState.setState(() {
                  //   refresh = refresh == false ? true : false;
                  // });
                },
              );
            },
          ),
        ):Center(child: Text('Empty List'),),
      ),
    );
  }

  void changeTaskID(String taskId, String newTaskID) {
    Map task = downloadData?.firstWhere(
          (element) => element['taskId'] == taskId,
      orElse: () => null,
    );
    // _scaffoldKey.currentState.setState(() {
    //   task['taskId'] = newTaskID;
    // });
  }

}
