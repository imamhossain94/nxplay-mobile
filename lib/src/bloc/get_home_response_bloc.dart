import 'package:nx_play/src/models/home_response.dart';
import 'package:nx_play/src/services/video_service/video_service.dart';
import 'package:rxdart/rxdart.dart';

class HomeResponseBloc {
  final VideoServices _videoServices = VideoServices();
  final BehaviorSubject<HomeResponse> _subject =
      BehaviorSubject<HomeResponse>();

  getMovies() async {
    HomeResponse response = await _videoServices.getHomeVideos();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<HomeResponse> get subject => _subject;
  
}
final homeResponseBloc = HomeResponseBloc ();