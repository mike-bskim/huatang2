import 'dart:ui';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/component/common_component.dart';
import 'package:huatang2/src/component/ex2_component.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/model/multi_msg.dart';

//
class ListEx2Page extends StatefulWidget {
  final teacherUid;
  final code;
  final testResultCntStudent;

//  final userInfo;
  ListEx2Page(this.teacherUid, this.code, this.testResultCntStudent); // , this.userInfo

  @override
  _ListEx2PageState createState() => _ListEx2PageState();
}

class _ListEx2PageState extends State<ListEx2Page> {
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  final _textController0 = TextEditingController();
  final _textController1 = TextEditingController();
  bool questionFlag = false;
  bool _deleteFlag = false;
  int _currentPage = 0;
  var qTotal = 0;
  final _multiMsg = MultiMessageListEx2();
  var newItems = [];
  final _testResult = [];

  Color? _buttonColor1;
  Color? _buttonColor2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTestResult();
    _getSubCnt();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textController0.dispose();
    _textController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _multiMsg.convertDescription(_userInfoController.userInfo['userLangType']);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(38, 100, 100, 1.0),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: (!questionFlag || widget.testResultCntStudent > 0)
            ? null
            : <Widget>[
                PopupMenuButton<int>(
                  icon: Icon(Icons.sort),
                  onSelected: (value) {
                    if (value == 0) {
                      _modifyQuestion();
                    } else {
                      deleteQuestion();
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(value: 0, child: Text(_multiMsg.strModify)),
                      PopupMenuItem(value: 1, child: Text(_multiMsg.strDelete))
                    ];
                  },
                )
              ],
        title: questionFlag
            ? Text(
                (_currentPage + 1).toString() + ' / ' + qTotal.toString(),
                style: TextStyle(color: Colors.white54),
              )
            : Text(''),
      ),
      body: _buildBody(),
    );
  }

//
  Widget _buildBody() {
    return WillPopScope(
      onWillPop: () {
//        Navigator.of(context).pop(true);
        Get.back(result: true);
        return Future.value(true);
      },
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.teacherUid) //post
            .doc(widget.code)
            .collection('post_sub')
            .orderBy('datetime')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data != null && !snapshot.hasError) {
            var items = snapshot.data.docs ?? [];

            newItems.clear();

            if (items.length < 1) {
              return Text(_multiMsg.strNoData);
            }

            for (var i = 0; i < items.length; i++) {
              newItems.add(items[i]);
            }

            return _buildCarouselSlider(newItems);
          }

          return Text(_multiMsg.strNoList);
        },
      ),
    );
  }

  Future _modifyQuestion() async {
//    final result = await Navigator.push(
//      context,
//      MaterialPageRoute(
//          builder: (context) =>
//              ModifySubEx2Page(document: newItems[_currentPage],
//                  userInfo: widget.userInfo)),
//    );
//    if (result) {
//      setState(() {
//      });
//    }
  }

  void deleteData(idParent, idChild) {
    var _deletePhotoUrl;
    _deletePhotoUrl = newItems[_currentPage]['photoUrl'];

    FirebaseFirestore.instance
        .collection(widget.teacherUid) //post
        .doc(idParent)
        .collection('post_sub')
        .doc(idChild)
        .delete()
        .catchError((e) {
      print(e);
    }).then((onValue) async {
      if (_deletePhotoUrl == 'NoImage') {
        print('There is no Image');
      } else {
        final ref = FirebaseStorage.instance.refFromURL(_deletePhotoUrl);
        await ref.delete(); // delete sub question's pictures
      }
      _getSubCnt(); // get the qTotal after delete question
    });
    // 삭제되기 전에 다시 setState/build 할것.
    // then 에서 호출하면 순간 오류 화면 보임.
    setState(() {
      _currentPage = 0;
      _deleteFlag = true;
    });
  }

  // ignore: always_declare_return_types
  deleteQuestion() async {
    //handleClear, deleteChapter
    try {
      var delete = await deleteLoanWarning(
        context,
        _multiMsg.strWarnMessage,
        _multiMsg.strWarnDelete,
      );
      if (delete.toString() == 'true') {
        //call setState here to rebuild your state.
        deleteData(newItems[_currentPage]['id_parent'], newItems[_currentPage]['id_child']);
      }
    } catch (error) {
      print('error clearing notifications' + error.toString());
    }
  }

  Future<bool> deleteLoanWarning(BuildContext context, String title, String msg) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => WarningYesNo(
            title: title,
            msg: msg,
            YesMsg: _multiMsg.strYes,
            NoMsg: _multiMsg.strNo,
          ),
        ) ??
        false;
  }

  void _getSubCnt() {
    FirebaseFirestore.instance
        .collection(widget.teacherUid) //post
        .doc(widget.code)
        .collection('post_sub')
        .get()
        .then((snapShot) {
      setState(() {
        qTotal = snapShot.docs.length;
        if (qTotal > 0) {
          questionFlag = true;
        } else {
          questionFlag = false;
        }
      });
    });
  }

  Future _loadTestResult() async {
    _testResult.clear();

//    var result = await FirebaseFirestore.instance
    await FirebaseFirestore.instance
        .collection(widget.teacherUid)
        .doc(widget.code) // chapter_code
        .collection('student')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                _testResult.add(doc.data());
              })
            });
//    if (result.toString() != null) {
//    }
  }

  Widget _buildCarouselSlider(List newItems) {
    var _num1 = 0.0;
    var _num2 = 0.0;
    String _score;
    var _qCnt = 0.0;

    for (var i = 0; i < _testResult.length; i++) {
      // i is students
      _qCnt += _testResult[i]['question_cnt'].toDouble();
    }
    _qCnt = _qCnt / _testResult.length.toDouble();

    if (_testResult.isEmpty) {
      _score = _multiMsg.strNoOne;
    } else if (_qCnt < newItems.length.toDouble()) {
      _score = '${_multiMsg.strMissMatching} ' + _qCnt.toString() + ')';
    } else {
      for (var i = 0; i < _testResult.length; i++) {
        // i is students
        if (_testResult[i]['student'][_currentPage] == true) _num1 += 1;
        if (_testResult[i]['student'][_currentPage] == false) _num2 += 1;
      }
      _num1 = _num1 / _testResult.length * 100;
      _num2 = _num2 / _testResult.length * 100;

      _score = 'selection - ';
      _score += 'True(${_num1.toStringAsFixed(0)}%)';
      _score += '    False(${_num2.toStringAsFixed(0)}%)';
    }

    if (newItems[_currentPage]['teacher_answer'] == true) {
      _buttonColor1 = Colors.lightGreen;
      _buttonColor2 = const Color(0xFFd2d2d2);
    } else {
      _buttonColor1 = const Color(0xFFd2d2d2);
      _buttonColor2 = Colors.lightGreen;
    }

    _textController0.text = newItems[_currentPage]['contents'];
    _textController1.text = newItems[_currentPage]['correct1'];

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
// QuestionTitle
            Container(
                padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
                child: QuestionTitle(
                  controller: _textController0,
                )),
            Padding(padding: EdgeInsets.all(4.0)),
// image & select example
            CarouselSlider.builder(
              itemCount: newItems.length,
              itemBuilder: (context, index, readIdx) {
                if (_deleteFlag == true) {
                  _deleteFlag = false;
                  index = 0;
                }
                return Container(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
//                  color: Colors.pinkAccent,
                  child: Column(
                    children: <Widget>[
// image
                      QuestionImageReadOnly(
                        photoUrl: newItems[index]['photoUrl'],
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
// select example
                      Container(
                        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                        child: TrueFalseBoxSetState(
                          trueMsg: _multiMsg.strTrue,
                          falseMsg: _multiMsg.strFalse,
                          editable: false,
                          trueColor: _buttonColor1,
                          falseColor: _buttonColor2,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Text(
                        '${_multiMsg.strAnswer}: ' + newItems[_currentPage]['correct1'],
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Text('${_multiMsg.strStudentCnt}: ${_testResult.length.toString()}'),
                      Padding(padding: EdgeInsets.all(4.0)),
                      Text(_score),
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                  height: 530,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentPage = index;
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
