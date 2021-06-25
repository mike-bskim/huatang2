import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/model/multi_msg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

//
class CreateSubEx4Page extends StatefulWidget {
  final document;
//  final userInfo;
  CreateSubEx4Page(this.document); // , this.userInfo

  @override
  _CreateSubEx4PageState createState() => _CreateSubEx4PageState();
}

class _CreateSubEx4PageState extends State<CreateSubEx4Page> {
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  var _checkboxValue1 = false;
  var _checkboxValue2 = false;
  var _checkboxValue3 = false;
  var _checkboxValue4 = false;
  final _textController0 = TextEditingController();
  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();
  final _textController3 = TextEditingController();
  final _textController4 = TextEditingController();
  bool iconColorFlag = true;
  bool _uploadFlag = false;
  var _teacherAnswer = 0;
  final _multiMsg = MultiMessageCreateEx4();

  File? _image; // PickedFile

  @override
  void dispose() {
    // TODO: implement dispose
    _textController0.dispose();
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    _textController4.dispose();
    _image?.delete();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _multiMsg.convertDescription(_userInfoController.userInfo['userLangType']);

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
          icon: iconColorFlag ? Icon(Icons.file_upload, color: Colors.white,)
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

    return WillPopScope(
      onWillPop: () {
//        Navigator.of(context).pop(true);
        Get.back(result: true);
        return Future.value(true);
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(hintText: _multiMsg.strHintTitle),
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
              padding: EdgeInsets.fromLTRB(16.0, 0.0, 32.0, 0.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 45,
                        child: Checkbox(
                          value: _checkboxValue1,
                          onChanged: (bool? value) {
                            setState(() {
                              _checkboxValue1 = true;
                              _checkboxValue2 = false;
                              _checkboxValue3 = false;
                              _checkboxValue4 = false;
                              _teacherAnswer = 1;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(12.0),
                              border: OutlineInputBorder(), labelText: '${_multiMsg.strEx}1)', hintText: _multiMsg.strHintInputEx),
                          controller: _textController1,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(4.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 45,
                        child: Checkbox(
                          value: _checkboxValue2,
                          onChanged: (bool? value) {
                            setState(() {
                              _checkboxValue1 = false;
                              _checkboxValue2 = true;
                              _checkboxValue3 = false;
                              _checkboxValue4 = false;
                              _teacherAnswer = 2;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(12.0),
                              border: OutlineInputBorder(), labelText: '${_multiMsg.strEx}2)', hintText: _multiMsg.strHintInputEx),
                          controller: _textController2,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(4.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 45,
                        child: Checkbox(
                          value: _checkboxValue3,
                          onChanged: (bool? value) {
                            setState(() {
                              _checkboxValue1 = false;
                              _checkboxValue2 = false;
                              _checkboxValue3 = true;
                              _checkboxValue4 = false;
                              _teacherAnswer = 3;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(12.0),
                              border: OutlineInputBorder(), labelText: '${_multiMsg.strEx}3)', hintText: _multiMsg.strHintInputEx),
                          controller: _textController3,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(4.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 45,
                        child: Checkbox(
                          value: _checkboxValue4,
                          onChanged: (bool? value) {
                            setState(() {
                              _checkboxValue1 = false;
                              _checkboxValue2 = false;
                              _checkboxValue3 = false;
                              _checkboxValue4 = true;
                              _teacherAnswer = 4;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(12.0),
                              border: OutlineInputBorder(), labelText: '${_multiMsg.strEx}4)', hintText: _multiMsg.strHintInputEx),
                          controller: _textController4,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _getImage() async {
    final image = await ImagePicker().getImage( //PickedFile ==> final
      source: ImageSource.gallery,
      maxHeight: 800,
    );

    if (image != null) {
      await _cropImage(image);
    } else {
      print('No image selected.');
    }
  }

// D:\workspace\Flutter\flutter_firebase\android\app\src\main\AndroidManifest.xml
  Future _cropImage(PickedFile? picked) async {
    var cropped = await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
        statusBarColor: Colors.red,
        toolbarColor: Colors.red,
        toolbarTitle: "Crop Image",
        toolbarWidgetColor: Colors.white,
//        lockAspectRatio: false,// no use
      ),
      sourcePath: picked!.path,
      aspectRatioPresets: [
//        CropAspectRatioPreset.original,// no use
//        CropAspectRatioPreset.square,// no use
//        CropAspectRatioPreset.ratio16x9,// no use
        CropAspectRatioPreset.ratio4x3,
      ],
      maxWidth: 600,
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

    if(_textController0.text.trim() == '') {
      _errorFlag = true;
      _msg = _multiMsg.strWarnTitle;
    } else if(_textController1.text.trim() == '') {
      _errorFlag = true;
      _msg = _multiMsg.strWarnEx1;
    } else if(_textController2.text.trim() == '') {
      _errorFlag = true;
      _msg = _multiMsg.strWarnEx2;
    } else if(_textController3.text.trim() == '') {
      _errorFlag = true;
      _msg = _multiMsg.strWarnEx3;
    } else if(_textController4.text.trim() == '') {
      _errorFlag = true;
      _msg = _multiMsg.strWarnEx4;
    } else if(_teacherAnswer == 0) {
      _errorFlag = true;
      _msg = _multiMsg.strWarnSelectAnswer;
    }

    if(_errorFlag == true) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(_multiMsg.strWarnMessage),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(_msg),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(_multiMsg.strOk),
              ),
            ],
          );
        },
      );
    }
    else {
      await _uploadImage();
    }
  }

  Future _uploadImage() async {
    setState(() {
      iconColorFlag = false;
      _uploadFlag = true;
    });

    var _email = widget.document['email'];
    _email = _email.split('@');
    var _picName = _email[0] + '_${DateTime.now().millisecondsSinceEpoch}.png';

    // 사진이 없는 경우.
    if(_image == null) {

      var doc = FirebaseFirestore.instance
          .collection(widget.document['teacher_uid'])
          .doc(widget.document['id'])
          .collection('post_sub')
          .doc(); // post collection 만들고, 하위에 문서를 만든다
      await doc.set({
        'id_parent': widget.document['id'],
        'id_child': doc.id,
        'datetime': DateTime.now().toString(),
        'photoUrl': 'NoImage',
        'chapter_title': widget.document['contents'],
        'contents': _textController0.text,
        'email': widget.document['email'],
        'displayName': widget.document['displayName'],
        'ex1': _textController1.text,
        'ex2': _textController2.text,
        'ex3': _textController3.text,
        'ex4': _textController4.text,
        'correct1': _checkboxValue1,
        'correct2': _checkboxValue2,
        'correct3': _checkboxValue3,
        'correct4': _checkboxValue4,
        'question_type': widget.document['question_type'],
        'idx': 0,
        'teacher_answer' : _teacherAnswer,
        'teacher_uid' : widget.document['teacher_uid'],
        'student_answer' : 0,
      }).then((onValue) {
//        Navigator.pop(context, true);
        Get.back(result: true);
      });

    }
    else {
      // 스토리지에 먼저 사진 업로드 하는 부분. StorageReference
      final firebaseStorageRef = FirebaseStorage.instance;
      var task = await firebaseStorageRef
          .ref() // 시작점
          .child(widget.document['teacher_uid']) // 경로, post
          .child('post_sub') // 경로
          .child(_picName)
          .putFile(_image!); // ^7.0.0
//        .onComplete; // ^4.0.1

//      if (task != null) {
        // 업로드 완료되면 데이터의 주소를 얻을수 있음, future object
        var downloadUrl = await task.ref.getDownloadURL();
        var doc = FirebaseFirestore.instance
            .collection(widget.document['teacher_uid'])
            .doc(widget.document['id'])
            .collection('post_sub')
            .doc(); // post collection 만들고, 하위에 문서를 만든다
        await doc.set({
          'id_parent': widget.document['id'],
          'id_child': doc.id,
          'datetime': DateTime.now().toString(),
          'photoUrl': downloadUrl.toString(),
          'chapter_title': widget.document['contents'],
          'contents': _textController0.text,
          'email': widget.document['email'],
          'displayName': widget.document['displayName'],
          'ex1': _textController1.text,
          'ex2': _textController2.text,
          'ex3': _textController3.text,
          'ex4': _textController4.text,
          'correct1': _checkboxValue1,
          'correct2': _checkboxValue2,
          'correct3': _checkboxValue3,
          'correct4': _checkboxValue4,
          'question_type': widget.document['question_type'],
          'idx': 0,
          'teacher_answer' : _teacherAnswer,
          'teacher_uid' : widget.document['teacher_uid'],
          'student_answer' : 0,
        }).then((onValue) {
//          Navigator.pop(context, true);
          Get.back(result: true);
        });
//      }
    }
  }

}