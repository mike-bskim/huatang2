import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/component/dialog_component.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/model/multi_msg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';



class CreateChapterPage extends StatefulWidget {

  @override
  _CreateChapterPageState createState() => _CreateChapterPageState();
}

class _CreateChapterPageState extends State<CreateChapterPage> {
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  final _textController0 = TextEditingController();
  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();
  final _textController3 = TextEditingController();
  bool iconColorFlag = true;
  bool _uploadFlag = false;
  var _questionType = '0';
  var _multiMsg;
  final _questionSelect = ['01. EX4']; // 파라미터 전달때문에 빈 리스트로 하면 안됌
  var _selectQuestionSelect;


  File? _image; // PickedFile

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _multiMsg = MultiMessageCreateMain();

}

  @override
  void dispose() {
    // TODO: implement dispose
    _textController0.dispose();
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    _image?.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _multiMsg.convertDescription(_userInfoController.userInfo['userLangType']);
    _questionSelect.clear();
    _questionSelect.add(_multiMsg.strEx4);
    _questionSelect.add(_multiMsg.strTF);
    _questionSelect.add(_multiMsg.strMatchPicture);
    _questionSelect.add(_multiMsg.strMatchText);
    _questionSelect.add(_multiMsg.strMultiEx4);//strMultiEx4

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Pick Image',
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Color.fromRGBO(38, 100, 100, 1.0),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      title: Text(_multiMsg.strAppBarTitle,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: iconColorFlag
            ? Icon(Icons.file_upload, color: Colors.white,)
            : Icon(Icons.file_upload, color: Color.fromRGBO(38, 100, 100, 1.0)),
          tooltip: 'upload Image',
          onPressed: iconColorFlag ? _checkUploadDialog : null, //_uploadImage,
        )
      ],
    );
  }

  Widget _buildBody() {
    if(_uploadFlag) {
      _uploadFlag = false;
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: _multiMsg.strHintTitle,
              ),
              controller: _textController0,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12)
            ),
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
            width: 350,
            height: 200,
            child: _image == null ? Center(child: Text(_multiMsg.strNoImage))
                : Image.file(_image!, fit: BoxFit.cover,),
          ),
          Padding(padding: EdgeInsets.all(8.0)),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${_multiMsg.strQuestionType}  :  '),
                DropdownButton<String>(
                  onChanged: (String? value) => popupQuestionTypeSelected(value!),
                  value: _selectQuestionSelect,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  items: _questionSelect.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(4.0)),
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12.0),
                      border: OutlineInputBorder(), hintText: _multiMsg.strHintDescription),//labelText: 'Description',
                    controller: _textController1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void popupQuestionTypeSelected(String value) {
    setState(() {
      _selectQuestionSelect = value;

      if(value.substring(0,2) == '01') { // 01. EX4, so check only 2 bytes to compare
        _questionType = 'ex4';
      }
      else if(value.substring(0,2) == '02'){
        _questionType = 'ex2';
      }
      else if(value.substring(0,2) == '03') {
        _questionType = 'matchPicture';
      }
      else if(value.substring(0,2) == '04') {
        _questionType = 'matchText';
      }
      else if(value.substring(0,2) == '05') {
        _questionType = 'multiEx4';
      }
    });
  }

  Future _getImage() async {

    final image = await ImagePicker().getImage( //PickedFile ==> final
      source: ImageSource.gallery,
      maxWidth: 400,
    );

    if (image != null) {
//      _image = image as File?;
      await _cropImage(image);
    } else {
      print('No image selected.');
    }
  }

// D:\workspace\Flutter\flutter_firebase\android\app\src\main\AndroidManifest.xml
  Future _cropImage(PickedFile? picked) async {
    var cropped = await ImageCropper.cropImage(
      sourcePath: picked!.path,
      aspectRatioPresets: [
//        CropAspectRatioPreset.original,  // no use
//        CropAspectRatioPreset.square,    // no use
//        CropAspectRatioPreset.ratio16x9, // no use
        CropAspectRatioPreset.ratio4x3,
      ],
      androidUiSettings: AndroidUiSettings(
        statusBarColor: Colors.red,
        toolbarColor: Colors.red,
        toolbarTitle: "Crop Image",
        toolbarWidgetColor: Colors.white,
//        hideBottomControls: true, // no use
//        lockAspectRatio: false,   // no use
      ),
      maxHeight: 600,
    );
    if (cropped != null) {
      setState(() {
        _image = cropped;
      });
    }
  }

  Future<void> _checkUploadDialog() async {
    var _errorFlag = false;
    var _msg;

    if(_textController0.text.trim() == '') { // checking the title
      _errorFlag = true;
      _msg = _multiMsg.strWarnTitle;
    } else if(_image == null) { // image
      _errorFlag = true;
      _msg = _multiMsg.strWarnImage;
    } else if(_questionType == '0') { // question type
      _errorFlag = true;
      _msg = _multiMsg.strWarnType;
    }

    if(_errorFlag == true) { // any missing message -> warning dialog
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return WarningNotice(title: _multiMsg.strWarnMessage, msg: _msg, btnMsg: _multiMsg.strOk, );
        },
      );
    }
    else { // all input is available
      await _uploadImage();
    }
  }

  Future _uploadImage() async {

    setState(() {
      iconColorFlag = false;
      _uploadFlag = true;
    });

    // _picName = email + datetime
    var _email = _userInfoController.userInfo['email'];
    _email = _email.split('@');
    var _picName = _email[0] + '_${DateTime.now().millisecondsSinceEpoch}.png';

    final firebaseStorageRef = FirebaseStorage.instance; // 스토리지에 먼저 사진 업로드 하는 부분. StorageReference
    var task = await firebaseStorageRef
        .ref() // 시작점
        .child(_userInfoController.userInfo['uid']) // 경로, post
        .child(_picName)
        .putFile(_image!); //^7.0.0
//        .onComplete; // ^4.0.1

//    if (task != null) {
      // 업로드 완료되면 데이터의 주소를 얻을수 있음, future object
      var downloadUrl = await task.ref.getDownloadURL();

      var doc =
          FirebaseFirestore.instance.collection(_userInfoController.userInfo['uid']).doc(); // post collection 만들고, 하위에 문서를 만든다
      await doc.set({
        'id': doc.id,
        'datetime' : DateTime.now().toString(),
        'photoUrl': downloadUrl.toString(),
        'contents': _textController0.text,
        'email': _userInfoController.userInfo['email'],
        'teacher_uid': _userInfoController.userInfo['uid'],
        'displayName': _userInfoController.userInfo['displayName'],
        'userPhotoUrl': _userInfoController.userInfo['photoURL'],
        'description1': _textController1.text,
        'description2': _textController2.text,
        'description3': _textController3.text,
        'description4': '',
        'question_type': _questionType,
        'question_cnt': 0,
        'favorite': [],
      }).then((onValue) {
//        Navigator.pop(context);
        Get.back();
      });
//    }
  }

}


