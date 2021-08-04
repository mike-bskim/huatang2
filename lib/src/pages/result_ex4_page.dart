import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/component/common_component.dart';
import 'package:huatang2/src/component/ex4_component.dart';
import 'package:huatang2/src/controller/ex4_controller.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/model/multi_msg.dart';


//enum studentSelect { one, two, three, four }

class ResultEx4Page extends StatefulWidget {
  final examList;
  final answerHistory;
  final studentInfo;
//  final userInfo;
  ResultEx4Page(this.examList, this.answerHistory, this.studentInfo); // , this.userInfo,

  @override
  _ResultEx4PageState createState() => _ResultEx4PageState();
}

class _ResultEx4PageState extends State<ResultEx4Page> {
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  final Ex4Controller _ex4Controller = Get.put(Ex4Controller(), tag: '_testresult');
  final _textController0 = TextEditingController();
  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();
  final _textController3 = TextEditingController();
  final _textController4 = TextEditingController();
  final _firebaseFirestore = FirebaseFirestore.instance;
//  studentSelect _studentSelect;

  var _currentPage = 0;
  var qTotal = 0;
  var _boxColor1 = Colors.white70;
  var _boxColor2 = Colors.white70;
  var _boxColor3 = Colors.white70;
  var _boxColor4 = Colors.white70;
  var _multiMsg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _multiMsg = MultiMessageResultEx4();
    qTotal = widget.examList.length;
    _loadResult();
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

    return WillPopScope(
      onWillPop: () {
//        _loadResult();
        Navigator.of(context).pop(true);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(38, 100, 100, 1.0),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text((_currentPage + 1).toString() + ' / ' + qTotal.toString(),
            style: TextStyle(color: Colors.white54),
          ),
        ),
        body: _buildCarouselSlider(widget.examList),
      ),
    );
  }

//widget.examList.length, widget.examList/newItems[_currentPage]['answer1'], studentUid
  Future _saveResult() async {

    var _teacher = [];
    var _student = [];
    var _point = [];
    var _resultMap = <String, dynamic>{};

    for(var i=0; i < qTotal; i++) {
      _teacher.add(widget.examList[i].teacher_answer);
      _student.add(widget.answerHistory[i]);
      if(widget.examList[i].teacher_answer == widget.answerHistory[i]) {
        _point.add(1);
      } else {
        _point.add(0);
      }
    }

    _resultMap = {
      'teacher_uid': widget.examList[0].teacher_uid,
      'chapter_code': widget.examList[0].id_parent,
      'student_uid': widget.studentInfo.studentUid,
      'chapter_title': widget.examList[0].chapter_title,
      'id': widget.studentInfo.studentUid,
      'student_name': widget.studentInfo.studentName,
      'email': widget.studentInfo.studentEmail,
      'datetime': DateTime.now().toString(),
      'question_cnt': qTotal,
      'user_type': widget.studentInfo.userType,
      'teacher': _teacher,
      'student': _student,
      'point': _point,
      'question_type': widget.examList[0].question_type,
      'chapterPhotoUrl': widget.studentInfo.chapterPhotoUrl,
    };

// teacher >> Chapter >> student >> studentUid
    var _testResult = _firebaseFirestore
      .collection(widget.examList[0].teacher_uid) // teacher uid
      .doc(widget.examList[0].id_parent) // chapter_code
      .collection('student')
      .doc(widget.studentInfo['studentUid']); // student uid

    await _testResult.set(_resultMap).then((onValue) {
    });

// student >> studentUid >> studentUid >> chapter_code
    var _testResultStudent = _firebaseFirestore
        .collection('student') // student
        .doc(widget.studentInfo['studentUid']) // student uid
        .collection(widget.studentInfo['studentUid']) // student uid
        .doc(widget.examList[0].id_parent); // chapter_code

    await _testResultStudent.set(_resultMap).then((onValue) {
    });

// teacher >> student >> student >> studentUid
    var _studentMap = {
      'student_uid': widget.studentInfo['studentUid'],
      'user_type': widget.studentInfo['userType'],
      'student_name': widget.studentInfo['studentName'],
      'email': widget.studentInfo['studentEmail'],
      'datetime': DateTime.now().toString(),
    };
    var _testResult1 = _firebaseFirestore
      .collection(widget.examList[0].teacher_uid) // teacher uid
      .doc('student')
      .collection('student')
      .doc(widget.studentInfo['studentUid']); // student uid

    await _testResult1.set(_studentMap).then((onValue) {
    });

  }
//widget.examList.length, widget.examList/newItems[_currentPage]['answer1'], studentUid
  Future _loadResult() async {

    await _firebaseFirestore
      .collection(widget.examList[0].teacher_uid)
      .doc(widget.examList[0].id_parent) // chapter_code
      .collection('student')
      .doc(widget.studentInfo['studentUid'])
      .get()
      .then((doc) {
        if (doc.exists) {
          if(widget.studentInfo['previous'] == 'test'){
            _dialogBlockSaveResult();
            _saveResult();
          }
        } else {
          _saveResult();
        }
    });
  }

  Widget _buildCarouselSlider(List newItems) {

    _boxColor1 = Colors.white70;
    _boxColor2 = Colors.white70;
    _boxColor3 = Colors.white70;
    _boxColor4 = Colors.white70;

    _textController0.text = newItems[_currentPage].question_title;
    _textController1.text = newItems[_currentPage].ex1;
    _textController2.text = newItems[_currentPage].ex2;
    _textController3.text = newItems[_currentPage].ex3;
    _textController4.text = newItems[_currentPage].ex4;

    if (widget.answerHistory.isNotEmpty) {
      if (widget.answerHistory[_currentPage] == 1) {
        _ex4Controller.studentSelectReadOnly = StudentSelect.one;
      } else if (widget.answerHistory[_currentPage] == 2) {
        _ex4Controller.studentSelectReadOnly = StudentSelect.two;
      } else if (widget.answerHistory[_currentPage] == 3) {
        _ex4Controller.studentSelectReadOnly = StudentSelect.three;
      } else if (widget.answerHistory[_currentPage] == 4) {
        _ex4Controller.studentSelectReadOnly = StudentSelect.four;
      } else {
        _ex4Controller.studentSelectReadOnly = StudentSelect.zero;
      }
    }

    if (newItems[_currentPage].teacher_answer == widget.answerHistory[_currentPage]) {
      if (widget.answerHistory[_currentPage] == 1) {
        _boxColor1 = Colors.lightGreen;
      } else if (widget.answerHistory[_currentPage] == 2) {
        _boxColor2 = Colors.lightGreen;
      } else if (widget.answerHistory[_currentPage] == 3) {
        _boxColor3 = Colors.lightGreen;
      } else if (widget.answerHistory[_currentPage] == 4) {
        _boxColor4 = Colors.lightGreen;
      }

    } else {
      if (widget.answerHistory[_currentPage] == 1) {
        _boxColor1 = Colors.redAccent;
      } else if (widget.answerHistory[_currentPage] == 2) {
        _boxColor2 = Colors.redAccent;
      } else if (widget.answerHistory[_currentPage] == 3) {
        _boxColor3 = Colors.redAccent;
      } else if (widget.answerHistory[_currentPage] == 4) {
        _boxColor4 = Colors.redAccent;
      }

      if (newItems[_currentPage].teacher_answer == 1) {
        _boxColor1 = Colors.lightGreen;
      } else if (newItems[_currentPage].teacher_answer == 2) {
        _boxColor2 = Colors.lightGreen;
      } else if (newItems[_currentPage].teacher_answer == 3) {
        _boxColor3 = Colors.lightGreen;
      } else if (newItems[_currentPage].teacher_answer == 4) {
        _boxColor4 = Colors.lightGreen;
      }
    }

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
//            Padding(padding: EdgeInsets.all(8.0)),
// QuestionTitle
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
              child: QuestionTitle(controller: _textController0,),
            ),
            Padding(padding: EdgeInsets.all(4.0)),
// image & select example
            CarouselSlider.builder(
              itemCount: newItems.length,
              itemBuilder: (context, index, realIdx) {

                return Container(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
//                  color: Colors.pinkAccent,
                  child: Column(
                    children: <Widget>[
// image
                      QuestionImageReadOnly(photoUrl: newItems[index].photoUrl,),
                      Padding(padding: EdgeInsets.all(8.0)),
// ReadOnly select example radio box
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                        child: RadioBoxExampleReadOnly(
                          labelText: _multiMsg.strEx, editable: false,
                          controller1: _textController1,
                          controller2: _textController2,
                          controller3: _textController3,
                          controller4: _textController4,
                          boxColor1: _boxColor1,
                          boxColor2: _boxColor2,
                          boxColor3: _boxColor3,
                          boxColor4: _boxColor4,
                        ),
                      ),
                    ]
                  ),
                );
              },
              options: CarouselOptions(
                height: 500,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                  });
                }),
            ),

          ]
        ),
      ),
    );
  }

  Future<void> _dialogBlockSaveResult() async {
    var _msg = _multiMsg.strWarnSave;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return WarningNotice(
          title: _multiMsg.strWarnMessage,
          msg: _msg,
          btnMsg: _multiMsg.strOk,
        );
      },
    );
  }

}
