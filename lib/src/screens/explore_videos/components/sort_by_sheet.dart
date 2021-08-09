import 'package:flutter/material.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class MoreMovieSortBy extends StatefulWidget {
  final Function(Map<String, String>) onPramChange;
  const MoreMovieSortBy({Key key, @required this.onPramChange}):super(key: key);
  @override
  _MoreMovieSortByState createState() => _MoreMovieSortByState();
}

class _MoreMovieSortByState extends State<MoreMovieSortBy> {
  final Map<String, String> params = {};
  int ratingScore = 1;
  bool sortAsc = false, sortDec = false, title = false, imdbRating = false, views = false, movie = false, series = false;

  @override
  void initState() {
    sortAsc = getMoreMovieSortAsc();
    sortDec = getMoreMovieSortDes();
    title = getMoreMovieSortTitle();
    imdbRating = getMoreMovieSortImdb();
    views = getMoreMovieSortViews();
    movie = getMoreMovieTypeMovie();
    series = getMoreMovieTypeSeries();
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

    if(sortAsc == true){
      params['sort'] = 'asce';
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

    widget.onPramChange(params);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: ThemesMode.isDarkMode?AppColors.backgroundDark:AppColors.backgroundLight,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(-0.5, -0.5), // changes position of shadow
            ),
          ]
      ),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
            child: Row(
              children: [
                Text('Sort By', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,)),
                Spacer(),
                FlatButton(onPressed: (){
                  getInitializedParams();
                }, child: Text('Save'))
              ],
            ),
          ),
          Divider(thickness: 1, height: 1,),
          CheckboxListTile(
            title: new Text('Title',
              style: new TextStyle(fontSize: 20,),
            ),
            onChanged: (bool value) {
              setState(() {
                if(value == true){
                  title = true;
                  imdbRating = false;
                  views = false;
                }else{
                  //title = false;
                  imdbRating = false;
                  views = false;
                }
              });
              setMoreMovieSortTitle(title);
              setMoreMovieSortImdb(imdbRating);
              setMoreMovieSortViews(series);
            },
            checkColor: AppColors.textWhite,
            activeColor:
            ThemesMode.isDarkMode ? Colors.yellow[800] : AppColors.textBlue,
            value: title,
          ),
          CheckboxListTile(
            title: new Text('Imdb Rating',
              style: new TextStyle(fontSize: 20,),
            ),
            onChanged: (bool value) {
              setState(() {
                if(value == true){
                  title = false;
                  imdbRating = true;
                  views = false;
                }else{
                  title = false;
                  //imdbRating = false;
                  views = false;
                }
              });
              setMoreMovieSortTitle(title);
              setMoreMovieSortImdb(imdbRating);
              setMoreMovieSortViews(series);
            },
            checkColor: AppColors.textWhite,
            activeColor:
            ThemesMode.isDarkMode ? Colors.yellow[800] : AppColors.textBlue,
            value: imdbRating,
          ),
          CheckboxListTile(
            title: new Text('Views',
              style: new TextStyle(fontSize: 20,),
            ),
            onChanged: (bool value) {
              setState(() {
                setState(() {
                  if(value == true){
                    title = false;
                    imdbRating = false;
                    views = true;
                  }else{
                    title = false;
                    imdbRating = false;
                    //views = false;
                  }
                });
              });
              setMoreMovieSortTitle(title);
              setMoreMovieSortImdb(imdbRating);
              setMoreMovieSortViews(views);
            },
            checkColor: AppColors.textWhite,
            activeColor:
            ThemesMode.isDarkMode ? Colors.yellow[800] : AppColors.textBlue,
            value: views,
          ),

          Divider(thickness: 1, height: 1,),
          CheckboxListTile(
            title: new Text('Ascending',
              style: new TextStyle(fontSize: 20,),
            ),
            onChanged: (bool value) {
              setState(() {
                if(sortDec == true && value == true){
                  sortAsc = value;
                  sortDec = false;
                }else{
                  sortAsc = value;
                }
              });
              setMoreMovieSortAsc(sortAsc);
              setMoreMovieSortDes(sortDec);
            },
            checkColor: AppColors.textWhite,
            activeColor:
            ThemesMode.isDarkMode ? Colors.yellow[800] : AppColors.textBlue,
            value: sortAsc,
          ),
          CheckboxListTile(
            title: new Text('Descending',
              style: new TextStyle(fontSize: 20,),
            ),
            onChanged: (bool value) {
              setState(() {
                if(sortAsc == true && value == true){
                  sortAsc = false;
                  sortDec = value;
                }else{
                  sortDec = value;
                }
              });
              setMoreMovieSortAsc(sortAsc);
              setMoreMovieSortDes(sortDec);
            },
            checkColor: AppColors.textWhite,
            activeColor:
            ThemesMode.isDarkMode ? Colors.yellow[800] : AppColors.textBlue,
            value: sortDec,
          ),
          Divider(thickness: 1, height: 1,),
          CheckboxListTile(
            title: new Text('Movie',
              style: new TextStyle(fontSize: 20,),
            ),
            onChanged: (bool value) {
              setState(() {
                if(series == true && value == true){
                  movie = value;
                  series = false;
                }else{
                  movie = value;
                }
              });
              setMoreMovieTypeMovie(movie);
              setMoreMovieTypeSeries(series);
            },
            checkColor: AppColors.textWhite,
            activeColor:
            ThemesMode.isDarkMode ? Colors.yellow[800] : AppColors.textBlue,
            value: movie,
          ),

          CheckboxListTile(
            title: new Text('Series',
              style: new TextStyle(fontSize: 20,),
            ),
            onChanged: (bool value) {
              setState(() {
                if(movie == true && value == true){
                  series = value;
                  movie = false;
                }else{
                  series = value;
                }
              });
              setMoreMovieTypeMovie(movie);
              setMoreMovieTypeSeries(series);
            },
            checkColor: AppColors.textWhite,
            activeColor:
            ThemesMode.isDarkMode ? Colors.yellow[800] : AppColors.textBlue,
            value: series,
          ),
        ],
      ),
    );
  }





}

