import 'package:flutter/material.dart';
import 'package:nx_play/src/models/single_video/single_video.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class GenresListWidget extends StatelessWidget {
  const GenresListWidget({
    Key key,
    @required this.video,
  }) : super(key: key);

  final SingleVideo video;

  List<Widget> _buildGenresChips() {
    return video.genres.map((genres) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 8,
        ),
        child: Chip(
          //elevation:1.0,
          label: Text(genres),
          //labelStyle:TextStyle(fontSize: 10),
          backgroundColor: Colors.black12,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    return Container(
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _buildGenresChips(),
                )),
          ),
          Container(
              height: 30, child: VerticalDivider(color: Colors.grey[600])),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: Text(video.ageRating,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
