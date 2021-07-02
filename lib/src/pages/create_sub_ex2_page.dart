import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/component/common_component.dart';
import 'package:huatang2/src/component/ex2_component.dart';
import 'package:huatang2/src/controller/ex2_controller.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/model/multi_msg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

//import 'multi_msg.dart';

//
class CreateSubEx2Page extends StatefulWidget {
  final document;
//  final userInfo;
  CreateSubEx2Page(this.document); // , this.userInfo

  @override
  _CreateSubEx2PageState createState() => _CreateSubEx2PageState();
}

class _CreateSubEx2PageState extends State<CreateSubEx2Page> {
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  final Ex2Controller _ex2Controller = Get.put(Ex2Controller());
  final _textController0 = TextEditingController();
  final _textController1 = TextEditingController();
  bool iconColorFlag = true;
  bool _uploadFlag = false;
//  bool? _teacherAnswer;
  final _multiMsg = MultiMessageCreateEx2();

  File? _image; // PickedFile

  @override
  void dispose() {
    // TODO: implement dispose
    _textController0.dispose();
    _textController1.dispose();
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
        Get.back(result: true);
        return Future.value(true);
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
// QuestionTitle
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
              child: QuestionTitle(titleHint: _multiMsg.strHintTitle, controller: _textController0, editable: true,),
            ),
            Padding(padding: EdgeInsets.all(4.0)),
// image
            Container(
              padding: EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
              child: QuestionImage(image: _image, msg: _multiMsg.strNoImage),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
// select example
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: TrueFalseBoxSetState(trueMsg: _multiMsg.strTrue, falseMsg: _multiMsg.strFalse,),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: QuestionTitle(titleHint: _multiMsg.strHintInputAnswer, controller: _textController1, editable: true,),
//              TextField(
//                decoration: InputDecoration(hintText: _multiMsg.strHintInputAnswer),
//                controller: _textController1,
//              ),
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
  Future _cropImage(PickedFile picked) async {
    var cropped = await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
        statusBarColor: Colors.red,
        toolbarColor: Colors.red,
        toolbarTitle: "Crop Image",
        toolbarWidgetColor: Colors.white,
//        lockAspectRatio: false,   // no use
      ),
      sourcePath: picked.path,
      aspectRatioPresets: [
//        CropAspectRatioPreset.original,    // no use
//        CropAspectRatioPreset.square,      // no use
//        CropAspectRatioPreset.ratio16x9,   // no use
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
      _msg = _multiMsg.strWarnInputAnswer;
    } else if(_ex2Controller.teacherAnswer == null) {
      _errorFlag = true;
      _msg = _multiMsg.strWarnSelectAnswer;
    }

    if(_errorFlag == true) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return WarningNotice(title: _multiMsg.strWarnMessage, msg: _msg, btnMsg: _multiMsg.strOk,);
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
        'ex1': '',
        'ex2': '',
        'ex3': '',
        'ex4': '',
        'correct1': _textController1.text,
        'correct2': '',
        'correct3': '',
        'correct4': '',
        'question_type': widget.document['question_type'],
        'idx': 0,
        'teacher_answer' : _ex2Controller.teacherAnswer,
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
          .putFile(_image!); //^7.0.0
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
          'ex1': '',
          'ex2': '',
          'ex3': '',
          'ex4': '',
          'correct1': _textController1.text,
          'correct2': '',
          'correct3': '',
          'correct4': '',
          'question_type': widget.document['question_type'],
          'idx': 0,
          'teacher_answer' : _ex2Controller.teacherAnswer,
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
