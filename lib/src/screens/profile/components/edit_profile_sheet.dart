import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nx_play/src/models/profile/update_profile_response.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/review_sheet_text_field.dart';
import 'package:nx_play/src/services/nx_play/nx_play_auth_service.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/app_plugin.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class EditProfileSheet extends StatefulWidget {
  final VoidCallback onPressed;
  const EditProfileSheet(
      {Key key, @required this.onPressed}): super(key: key);

  @override
  _EditProfileSheetState createState() =>
      _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {

  File _image;
  String _fireStoreFileUrl;
  double _progress = 0;
  bool _isFileUploading = false;
  final Map<String, String> params = {};
  TextEditingController _nameController, _currentPasswordController, _passwordController, _confirmPasswordController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _currentPasswordController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _nameController.dispose();
    _currentPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    return Container(
      margin: EdgeInsets.fromLTRB(5, 8, 5, 15),
      decoration: BoxDecoration(
        color: ThemesMode.isDarkMode?AppColors.backgroundDark:AppColors.backgroundLight,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(-0.5, -0.5), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Wrap(
          children: [
            controlBar(context),
            _isFileUploading == true?
            Stack(
              children: [
                LinearProgressIndicator(
                  //value: _progress,
                  minHeight: 5,
                  backgroundColor: ThemesMode.isDarkMode?Colors.grey[900].withOpacity(0.9):Colors.grey[300].withOpacity(0.5),
                  valueColor: AlwaysStoppedAnimation<Color>(ThemesMode.isDarkMode ? AppColors.textYellow
                      : AppColors.textBlue,),
                ),
                Positioned.fill(
                    child: LinearProgressIndicator(
                      value: _progress,
                      minHeight: 5,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(ThemesMode.isDarkMode ? AppColors.textYellow
                          : AppColors.textBlue,),
                    ),
                )
              ],
            ) :Divider(height: 0.5,),
            _profileForm(),
            Container(height: 15,)
          ]),
    );
  }

  Widget controlBar(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 15,),
        Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        FlatButton(
          child: Text('Save'), onPressed: (){
            _updateProfile(context);
          }),
      ],
    );
  }
  
  Widget _profileForm(){
    return Wrap(
      children: [
        _profilePicture(),
        _info('-Your name must be at least 4 characters long.\n'
            '-Password must be at least 8 characters long.\n'
            '-If you wants to change your current password then current password is required.'),
        ReviewSheetTextField(hint: 'Name', controller: _nameController, maxLine:1, isPassword:false),
        ReviewSheetTextField(hint: 'Current Password', controller: _currentPasswordController, maxLine:1, isPassword:true),
        ReviewSheetTextField(hint: 'New Password', controller: _passwordController, maxLine:1, isPassword:true),
        ReviewSheetTextField(hint: 'Confirm New Password', controller: _confirmPasswordController, maxLine:1, isPassword:true),
      ],
    );

  }

  Widget _profilePicture(){
    return Container(
      width: Responsive.screenWidth,
      padding: EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            child: InkWell(
              onTap: chooseFile,
              child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    color: ThemesMode.isDarkMode?AppColors.textBlack:AppColors.textWhite,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 0.5,
                          spreadRadius: 0.5,
                          offset: Offset.zero
                      )
                    ],
                    image: _image != null?
                    DecorationImage(
                      fit: BoxFit.fill,
                      image: FileImage(_image)):
                    DecorationImage(
                      scale: 5,
                      image: AssetImage('assets/add_photo.png')),
                  )),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Flexible(
            child: Text(
              'Click the camera icon to pick an image or Just simply change your information then hit save button to continue.',
              softWrap: true,
              overflow: TextOverflow.clip,
              style: TextStyle(
                color:ThemesMode.isDarkMode?Colors.white38:Colors.black45,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _info(String infoText){
    return Container(
      width: Responsive.screenWidth-15,
      margin: EdgeInsets.fromLTRB(15, 7.5, 20, 7.5),
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      decoration: BoxDecoration(
        color: ThemesMode.isDarkMode?Colors.grey[900].withOpacity(0.9):Colors.grey[300].withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(infoText, style: TextStyle(fontSize:16 ,color: ThemesMode.isDarkMode?Colors.white38:Colors.black45,))
    );
  }

  Future chooseFile() async {
    // ignore: deprecated_member_use
    await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 0, maxHeight: 400, maxWidth: 400).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile(BuildContext context) async {

    if(_image != null){
      FirebaseStorage storage = FirebaseStorage.instance;
      //Reference reference = storage.ref().child('user/${Path.basename(_image.path)}');
      Reference reference = storage.ref().child('user/${getUserName()}_${getUserId()}');
      UploadTask uploadTask = reference.putFile(_image);
      uploadTask.snapshotEvents.listen((event) {
        setState(() {
          _progress = event.bytesTransferred.toDouble() /
              event.totalBytes.toDouble();
        });
      });
      await uploadTask.whenComplete(() async{
        _fireStoreFileUrl = await reference.getDownloadURL();
        params['avatar'] = _fireStoreFileUrl;
      }).catchError((onError) {
        print(onError);
        AppPlugin().flushInfo(context, 'Firebase error: $onError');
        setState(() {
          _isFileUploading = false;
        });
      });
    }
  }

  void _updateProfile(BuildContext context) async{
    String name = _nameController.text;
    String currentPassword = _currentPasswordController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if(name.isEmpty && currentPassword.isEmpty && password.isEmpty && _image == null){
      AppPlugin().flushInfo(context, 'There have nothing to update');
    }else{
      setState(() {
        _isFileUploading = true;
      });
      if(params != null){
        params.clear();
      }
      if(name.isNotEmpty){
        params['name'] = name;
      }
      if(currentPassword.isNotEmpty){
        params['old_password'] = currentPassword;
      }
      if(password.isNotEmpty){
        params['password'] = password;
      }
      if(confirmPassword.isNotEmpty){
        params['password_confirmation'] = confirmPassword;
      }

      print('File URL ------------------------ $_fireStoreFileUrl');
      await uploadFile(context);
      print('File URL ------------------------ $_fireStoreFileUrl');

      try{
        UpdateProfileResponse updateProfileResponse
        = await NxPlayAuthServices().updateUserProfile(params);
        if(updateProfileResponse != null){
          setState(() {
            _isFileUploading = false;
          });
          setUserName(updateProfileResponse.updateProfile.profileData.name);
          setUserAvatar(updateProfileResponse.updateProfile.profileData.avatar);
          AppPlugin().flushInfo(context, 'Profile Updated');
          widget.onPressed();
        }
      }catch (e){
        setState(() {
          _isFileUploading = true;
        });
        AppPlugin().flushInfo(context, 'Error: $e');
      }
    }
  }

}
