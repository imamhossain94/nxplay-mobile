import 'package:flutter/material.dart';
import 'package:nx_play/src/models/video/get_search_videos_response.dart';
import 'package:nx_play/src/services/video_service/video_service.dart';
import 'package:rxdart/rxdart.dart';

class SearchVideosResponseBloc {
  final VideoServices _searchVideoServices = VideoServices();
  final BehaviorSubject<GetSearchVideosResponse> _subject =
      BehaviorSubject<GetSearchVideosResponse>();

  getSearchVideos(Map<String, String> parameters) async {
    GetSearchVideosResponse response = await _searchVideoServices.getSearchVideos(parameters);
    _subject.sink.add(response);
  }

  void drainStream(){ _subject.value = null; }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<GetSearchVideosResponse> get subject => _subject;
}
final searchVideoResponseBloc = SearchVideosResponseBloc ();