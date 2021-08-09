import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/components/bottom_navigation_bar.dart';
import 'package:nx_play/src/screens/search/components/body.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class SearchScreen extends StatefulWidget {
  final String title;
  const SearchScreen({Key key, @required this.title}):super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<String, String> params = {};
  var _textController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    _textController.addListener(() async{
      // params.clear();
      // setState(() {
      //   params['page'] = '1';
      //   params['search_key'] = _textController.text;
      // });
    });
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: FloatAppBar(controller: _textController, onPressed: () async{
          loading = true;
          await Future.delayed(Duration(seconds: 0), (){
            params.clear();
            params['page'] = '1';
            params['search_key'] = _textController.text;
            setState(() {
              loading = false;
            });
          });
        },),
        body: loading == false ? Body(key: UniqueKey(), params: params,):
        Center(child: SpinKitFadingCircle(
          color:
          ThemesMode.isDarkMode ? AppColors.textWhite : AppColors.textBlack,
          size: 50.0,
        ),),
        bottomNavigationBar: BottomNavBar(selectedMenu: AppConstants.rSearchScreen,),
      ),
    );
  }

}

class FloatAppBar extends StatelessWidget with PreferredSizeWidget {
  final VoidCallback onPressed;
  final TextEditingController controller;
  const FloatAppBar({Key key, @required this.onPressed, @required this.controller}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 5,
          right: 10,
          left: 10,
          bottom: 5,
          child: Card(
            //color: Colors.white,
            elevation: 5.0,
            child: Row(
              children: <Widget>[
                Material(
                  type: MaterialType.transparency,
                  child: IconButton(
                    splashColor: Colors.grey,
                    icon: FaIcon(FontAwesomeIcons.search),
                    onPressed: () {
                      onPressed();
                    },
                  ),
                ),
                Expanded(
                  child: TextField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    controller: controller,
                    //autofocus: true,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      onPressed();
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        hintText: "Search..."),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight+15);
}

