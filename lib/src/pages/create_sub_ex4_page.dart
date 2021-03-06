import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/component/common_component.dart';
import 'package:huatang2/src/component/ex4_component.dart';
import 'package:huatang2/src/controller/ex4_controller.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/model/multi_msg.dart';
import 'package:huatang2/src/model/questions.dart';
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
  final Ex4Controller _ex4Controller = Get.put(Ex4Controller());
  final _textController0 = TextEditingController();
  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();
  final _textController3 = TextEditingController();
  final _textController4 = TextEditingController();
  bool iconColorFlag = true;
  bool _uploadFlag = false;
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
    print('CreateSubEx4Page >> build');
    _multiMsg.convertDescription(_userInfoController.userInfo['userLangType']);

    return Scaffold(
      appBar: AppBarWidget(
        appBarMsg: _multiMsg.strAppBarTitle,
        iconFlag: iconColorFlag,
        callBack: _checkUploadDialog,
      ), //_buildAppBar(),
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


  Widget _buildBody() {
    if (_uploadFlag) {
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
              padding: EdgeInsets.fromLTRB(16.0, 0.0, 32.0, 0.0),
              child: CheckBoxExample(labelText: _multiMsg.strEx, hintText: _multiMsg.strHintInputEx,
                        controller1: _textController1, controller2: _textController2,
                        controller3: _textController3, controller4: _textController4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _getImage() async {
    final image = await ImagePicker().getImage(
      //PickedFile ==> final
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

    if (_textController0.text.trim() == '') {
      _errorFlag = true;
      _msg = _multiMsg.strWarnTitle;
    } else if (_textController1.text.trim() == '') {
      _errorFlag = true;
      _msg = _multiMsg.strWarnEx1;
    } else if (_textController2.text.trim() == '') {
      _errorFlag = true;
      _msg = _multiMsg.strWarnEx2;
    } else if (_textController3.text.trim() == '') {
      _errorFlag = true;
      _msg = _multiMsg.strWarnEx3;
    } else if (_textController4.text.trim() == '') {
      _errorFlag = true;
      _msg = _multiMsg.strWarnEx4;
    } else if (_ex4Controller.teacherAnswer.value == 0) {
      _errorFlag = true;
      _msg = _multiMsg.strWarnSelectAnswer;
    }

    if (_errorFlag == true) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return WarningNotice(title: _multiMsg.strWarnMessage, msg: _msg, btnMsg: _multiMsg.strOk, );
        },
      );
    } else {
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

    // ????????? ?????? ??????.
    if (_image == null) {
      var doc = FirebaseFirestore.instance
          .collection(widget.document['teacher_uid'])
          .doc(widget.document['id'])
          .collection('post_sub')
          .doc(); // post collection ?????????, ????????? ????????? ?????????
//      await doc.add({

//      await doc.set({
//        'id_parent': widget.document['id'],
//        'id_child': doc.id,
//        'datetime': DateTime.now().toString(),
//        'photoUrl': 'NoImage',
//        'chapter_title': widget.document['contents'],
//        'contents': _textController0.text,
//        'email': widget.document['email'],
//        'displayName': widget.document['displayName'],
//        'ex1': _textController1.text,
//        'ex2': _textController2.text,
//        'ex3': _textController3.text,
//        'ex4': _textController4.text,
//        'correct1': _ex4Controller.checkValue1.value,//
//        'correct2': _ex4Controller.checkValue2.value,//
//        'correct3': _ex4Controller.checkValue3.value,//
//        'correct4': _ex4Controller.checkValue4.value,//
//        'question_type': widget.document['question_type'],
//        'idx': 0,
//        'teacher_answer': _ex4Controller.teacherAnswer.value,//
//        'teacher_uid': widget.document['teacher_uid'],
//        'student_answer': 0,
//      }).then((onValue) {
      await doc.set(Ex4_Questions(
          chapter_title: widget.document['contents'],
          question_title: _textController0.text,
          correct1: _ex4Controller.checkValue1.value,//
          correct2: _ex4Controller.checkValue2.value,//
          correct3: _ex4Controller.checkValue3.value,//
          correct4: _ex4Controller.checkValue4.value,//
          datetime: DateTime.now().toString(),
          displayName: widget.document['displayName'],
          email: widget.document['email'],
          ex1: _textController1.text,
          ex2: _textController2.text,
          ex3: _textController3.text,
          ex4: _textController4.text,
          id_child: doc.id,
          id_parent: widget.document['id'],
          idx: 0,
          photoUrl: 'NoImage',
          question_type: widget.document['question_type'],
          student_answer: 0,
          teacher_answer: _ex4Controller.teacherAnswer.value,//
          teacher_uid: widget.document['teacher_uid'],
          update_time: '',
      ).CreateToMap()).then((onValue) {//        Navigator.pop(context, true);
        Get.back(result: true);
      });
    } else {
      // ??????????????? ?????? ?????? ????????? ?????? ??????. StorageReference
      final firebaseStorageRef = FirebaseStorage.instance;
      var task = await firebaseStorageRef
          .ref() // ?????????
          .child(widget.document['teacher_uid']) // ??????, post
          .child('post_sub') // ??????
          .child(_picName)
          .putFile(_image!); // ^7.0.0
//        .onComplete; // ^4.0.1

//      if (task != null) {
      // ????????? ???????????? ???????????? ????????? ????????? ??????, future object
      var downloadUrl = await task.ref.getDownloadURL();
      var doc = FirebaseFirestore.instance
          .collection(widget.document['teacher_uid'])
          .doc(widget.document['id'])
          .collection('post_sub')
          .doc(); // post collection ?????????, ????????? ????????? ?????????
      await doc.set(Ex4_Questions(
        chapter_title: widget.document['contents'],
        question_title: _textController0.text,
        correct1: _ex4Controller.checkValue1.value,//
        correct2: _ex4Controller.checkValue2.value,//
        correct3: _ex4Controller.checkValue3.value,//
        correct4: _ex4Controller.checkValue4.value,//
        datetime: DateTime.now().toString(),
        displayName: widget.document['displayName'],
        email: widget.document['email'],
        ex1: _textController1.text,
        ex2: _textController2.text,
        ex3: _textController3.text,
        ex4: _textController4.text,
        id_child: doc.id,
        id_parent: widget.document['id'],
        idx: 0,
        photoUrl: downloadUrl.toString(),
        question_type: widget.document['question_type'],
        student_answer: 0,
        teacher_answer: _ex4Controller.teacherAnswer.value,//
        teacher_uid: widget.document['teacher_uid'],
        update_time: '',
      ).CreateToMap()).then((onValue) {
//          Navigator.pop(context, true);
        Get.back(result: true);
      });
//      }
    }
  }
}
