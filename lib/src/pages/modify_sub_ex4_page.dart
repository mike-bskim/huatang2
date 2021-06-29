import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/component/dialog_component.dart';
import 'package:huatang2/src/component/ex4_component.dart';
import 'package:huatang2/src/controller/ex4_controller.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/model/multi_msg.dart';

//
class ModifySubEx4Page extends StatefulWidget {
  final dynamic document;
//  final userInfo;
  ModifySubEx4Page({Key? key, this.document, }) : super(key: key);

  @override
  _ModifySubEx4PageState createState() => _ModifySubEx4PageState();
}

class _ModifySubEx4PageState extends State<ModifySubEx4Page> {
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  final SelectExampleController _selectExampleController = Get.put(SelectExampleController());
  final _textController0 = TextEditingController();
  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();
  final _textController3 = TextEditingController();
  final _textController4 = TextEditingController();
//  bool iconColorFlag = true;
  var _multiMsg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _multiMsg = MultiMessageModifyEx4();
    _textController0.text = widget.document['contents'];
    _textController1.text = widget.document['ex1'];
    _textController2.text = widget.document['ex2'];
    _textController3.text = widget.document['ex3'];
    _textController4.text = widget.document['ex4'];
    _selectExampleController.checkValue1.value = widget.document['correct1'];
    _selectExampleController.checkValue2.value = widget.document['correct2'];
    _selectExampleController.checkValue3.value = widget.document['correct3'];
    _selectExampleController.checkValue4.value = widget.document['correct4'];
    _selectExampleController.teacherAnswer.value = widget.document['teacher_answer'];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textController0.dispose();
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    _textController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _multiMsg.convertDescription(_userInfoController.userInfo['userLangType']);

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
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
        Obx(()=>IconButton(
          icon: _selectExampleController.iconFlag.value
              ? Icon(
                  Icons.file_upload,
                  color: Colors.white,
                )
              : Icon(
                  Icons.file_upload,
                  color: Color.fromRGBO(38, 100, 100, 1.0),
                ),
          tooltip: 'upload Image',
          onPressed: () {
            _selectExampleController.iconFlag.value ? _checkUploadDialog() : null;
          } , //_uploadImage,
        ),)
      ],
    );
  }

  Widget _buildBody() {

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
//              padding: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
              child: QuestionTitle(titleHint: _multiMsg.strHintTitle, controller: _textController0, editable: true,),
            ),
            Padding(padding: EdgeInsets.all(4.0)),
// image
            Container(
              padding: EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
              child: QuestionImageReadOnly(photoUrl: widget.document['photoUrl'],),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
// select example
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 0.0, 32.0, 0.0),
              child: SelectExample(labelText: _multiMsg.strEx, hintText: _multiMsg.strHintInputEx,
                controller1: _textController1, controller2: _textController2,
                controller3: _textController3, controller4: _textController4,
              ),
            ),
          ],
        ),
      ),
    );
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
    } else if(_selectExampleController.teacherAnswer.value == 0) {
      _errorFlag = true;
      _msg = _multiMsg.strWarnSelectAnswer;
    }

    if(_errorFlag == true) {
      return await showDialog<void>(
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
    _selectExampleController.setIconFlag(false);

    var doc = FirebaseFirestore.instance
        .collection(widget.document['teacher_uid']) // post
        .doc(widget.document['id_parent'])
        .collection('post_sub')
        .doc(widget.document['id_child']); // post collection 만들고, 하위에 문서를 만든다

    await doc.update({
//        'id_parent': widget.document['id'],
//        'id_child': doc.id,
//        'photoUrl': downloadUrl.toString(),
//        'email': widget.document['email'],
//        'displayName': widget.document['displayName'],
      'update_time': DateTime.now().toString(),
      'contents': _textController0.text,
      'ex1': _textController1.text,
      'ex2': _textController2.text,
      'ex3': _textController3.text,
      'ex4': _textController4.text,
      'correct1': _selectExampleController.checkValue1.value,
      'correct2': _selectExampleController.checkValue2.value,
      'correct3': _selectExampleController.checkValue3.value,
      'correct4': _selectExampleController.checkValue4.value,
      'idx': 0,
      'teacher_answer' : _selectExampleController.teacherAnswer.value,
    }).then((onValue) {
//      print('수정완료후 상위로 이동 modify->list');
      Get.back(result: true);
    });
  }

}