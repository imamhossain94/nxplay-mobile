import 'package:flutter/material.dart';
import 'package:nx_play/src/models/single_video/single_video_response.dart';
import 'package:nx_play/src/services/video_service/video_service.dart';
import 'package:rxdart/rxdart.dart';

class SingleVideoResponseBloc {
  final VideoServices _singleVideoServices = VideoServices();
  final BehaviorSubject<SingleVideoResponse> _subject =
      BehaviorSubject<SingleVideoResponse>();

  getSingleVideo(int videoId) async {
    SingleVideoResponse response = await _singleVideoServices.getSingleVideos(videoId);
    _subject.sink.add(response);
  }

  void drainStream(){ _subject.value = null; }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<SingleVideoResponse> get subject => _subject;
}
final singleVideoResponseBloc = SingleVideoResponseBloc ();