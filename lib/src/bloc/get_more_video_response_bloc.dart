import 'package:flutter/material.dart';
import 'package:nx_play/src/models/video/get_more_videos_response.dart';
import 'package:nx_play/src/services/video_service/video_service.dart';
import 'package:rxdart/rxdart.dart';

class MoreVideoResponseBloc {
  final VideoServices _moreVideoServices = VideoServices();
  final BehaviorSubject<GetMoreVideosResponse> _subject =
      BehaviorSubject<GetMoreVideosResponse>();

  getMoreVideos(Map<String, String> parameters) async {
    GetMoreVideosResponse response = await _moreVideoServices.getMoreVideos(parameters);
    _subject.sink.add(response);
  }

  void drainStream(){ _subject.value = null; }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<GetMoreVideosResponse> get subject => _subject;
}
final moreVideoResponseBloc = MoreVideoResponseBloc ();