import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/screens/explore_videos/components/body.dart';
import 'package:nx_play/src/screens/explore_videos/components/sort_by_sheet.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class MoreVideos extends StatefulWidget {
  final String title;
  const MoreVideos({Key key, @required this.title}):super(key: key);

  @override
  _MoreVideosState createState() => _MoreVideosState();
}

class _MoreVideosState extends State<MoreVideos> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<String, String> params = {};

  @override
  void initState() {
    getInitializedParams();
    super.initState();
  }

  void getInitializedParams(){
    bool sortAsc, sortDec, title, imdbRating, views, movie, series;
    sortAsc = getMoreMovieSortAsc();
    sortDec = getMoreMovieSortDes();
    title = getMoreMovieSortTitle();
    imdbRating = getMoreMovieSortImdb();
    views = getMoreMovieSortViews();
    movie = getMoreMovieTypeMovie();
    series = getMoreMovieTypeSeries();
    params.clear();
    setState(() {
      params['page'] = '1';
      if(sortAsc == true){
        params['sort'] = 'asc';
      }
      if(sortDec == true){
        params['sort'] = 'desc';
      }
      if(title == true){
        params['by'] = 'title';
      }
      if(imdbRating == true){
        params['by'] = 'imdb_rating';
      }
      if(views == true){
        params['by'] = 'views';
      }
      if(movie == true){
        params['type'] = 'movie';
      }
      if(series == true){
        params['type'] = 'series';
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text('${widget.title}'),
          actions: [
            Container(
              margin: EdgeInsets.fromLTRB(8, 5, 0, 5),
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              alignment: Alignment.center,
              child:IconButton(icon: FaIcon(FontAwesomeIcons.filter),
                onPressed: () {
                  _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
                      //return filterSheet(context);
                      return MoreMovieSortBy(onPramChange: (value){
                          setState(() {
                            //params.addAll(value);
                            getInitializedParams();
                          });
                        },
                      );
                    },
                  );
                },
              )
            )
          ]
        ),
        body: Body(key: UniqueKey(), params: params,),
      ),
    );
  }

}

