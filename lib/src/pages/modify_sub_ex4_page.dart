import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
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
  var _teacherAnswer = 0;
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
    _checkboxValue1 = widget.document['correct1'];
    _checkboxValue2 = widget.document['correct2'];
    _checkboxValue3 = widget.document['correct3'];
    _checkboxValue4 = widget.document['correct4'];
    _teacherAnswer =  widget.document['teacher_answer'];
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
        IconButton(
          icon: iconColorFlag
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
            _checkUploadDialog();
          } , //_uploadImage,
        )
      ],
    );
  }

  Widget _buildBody() {
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
              padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
              child: TextField(
                decoration: InputDecoration(hintText: _multiMsg.strHintTitle),
                controller: _textController0,
              ),
            ),
            Padding(padding: EdgeInsets.all(4.0)),
            Container(
              child: widget.document['photoUrl'] == 'NoImage' ?
              Container(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                width: 350,
                height: 20,
                child: null,
              ) :
              Container(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                width: 350,
                height: 200,
                child: Image.network(widget.document['photoUrl'],
                    fit: BoxFit.cover),
              ) ,
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
                              border: OutlineInputBorder(), labelText: '${_multiMsg.strEx}1)',
                              hintText: _multiMsg.strHintInputEx),
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
                              border: OutlineInputBorder(), labelText: '${_multiMsg.strEx}2)',
                              hintText: _multiMsg.strHintInputEx),
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
                              border: OutlineInputBorder(), labelText: '${_multiMsg.strEx}3)',
                              hintText: _multiMsg.strHintInputEx),
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
                              border: OutlineInputBorder(), labelText: '${_multiMsg.strEx}4)',
                              hintText: _multiMsg.strHintInputEx),
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
      return await showDialog<void>(
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
//                  Navigator.of(context).pop(false);
                  Get.back(result: false);
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
    });

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
        'correct1': _checkboxValue1,
        'correct2': _checkboxValue2,
        'correct3': _checkboxValue3,
        'correct4': _checkboxValue4,
        'idx': 0,
        'teacher_answer' : _teacherAnswer,
      }).then((onValue) {
//        Navigator.pop(context, true);
        Get.back(result: true);
      });
  }

}