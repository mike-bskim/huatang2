import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
//import 'modify_sub_ex4_page.dart';
import 'dart:async';

import 'package:huatang2/src/model/multi_msg.dart';


//
class ListEx4Page extends StatefulWidget {
  final teacherUid;
  final code;
  final testResultCntStudent;
//  final userInfo;

  ListEx4Page(
      this.teacherUid, this.code, this.testResultCntStudent); //

  @override
  _ListEx4PageState createState() => _ListEx4PageState();
}

class _ListEx4PageState extends State<ListEx4Page> {
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();
  final _textController3 = TextEditingController();
  final _textController4 = TextEditingController();
  var _checkboxValue1 = false;
  var _checkboxValue2 = false;
  var _checkboxValue3 = false;
  var _checkboxValue4 = false;

  bool questionFlag = false;
  bool _deleteFlag = false;
  int _currentPage = 0;
  var qTotal = 0;
  final _multiMsg = MultiMessageListEx4();

  var newItems = [];
  final _testResult = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSubCnt();
    _loadTestResult();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(38, 100, 100, 1.0),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: (!questionFlag || widget.testResultCntStudent > 0) ? null :
          <Widget>[
            PopupMenuButton<int>(
              icon: Icon(Icons.sort),
              onSelected: (value) {
                if (value == 0) {
//                  _modifyQuestion();
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


  Widget _buildBody()  {
    return WillPopScope(
      onWillPop: () {
//        Navigator.of(context).pop(true);
        Get.back(result: true);
        return Future.value(true);
      },
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection(widget.teacherUid) //post
            .doc(widget.code)
            .collection('post_sub')
            .orderBy('datetime')
            .get(),
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

//  Widget _buildBody() {
//    return WillPopScope(
//      onWillPop: () {
////        Navigator.of(context).pop(true);
//        Get.back(result: true);
//        return Future.value(true);
//      },
//      child: StreamBuilder(
//        stream: FirebaseFirestore.instance
//            .collection(widget.teacherUid) //post
//            .doc(widget.code)
//            .collection('post_sub')
//            .orderBy('datetime')
//            .snapshots(),
//        builder: (BuildContext context, AsyncSnapshot snapshot) {
//          if (!snapshot.hasData) {
//            return Center(child: CircularProgressIndicator());
//          }
//          if (snapshot.data != null && !snapshot.hasError) {
//            var items = snapshot.data.docs ?? [];
//
//            newItems.clear();
//
//            if (items.length < 1) {
//              return Text(_multiMsg.strNoData);
//            }
//
//            for (var i = 0; i < items.length; i++) {
//              newItems.add(items[i]);
//            }
//
//            return _buildCarouselSlider(newItems);
//          }
//          return Text(_multiMsg.strNoList);
//        },
//      ),
//    );
//  }


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
      if(_deletePhotoUrl == 'NoImage') {
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
        deleteData(newItems[_currentPage]['id_parent'],
            newItems[_currentPage]['id_child']);
      }
    } catch (error) {
      print('error clearing notifications' + error.toString());
    }
  }

  Future<bool> deleteLoanWarning(
      BuildContext context, String title, String msg) async {
    return await showDialog<bool>(
          builder: (context) => AlertDialog(
            title: Text(
              title,
//          style: new TextStyle(fontWeight: fontWeight, color: CustomColors.continueButton),
              textAlign: TextAlign.center,
            ),
            content: Text(
              msg,
//          textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              Container(
                decoration: BoxDecoration(),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    _multiMsg.strNo,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    _multiMsg.strYes,
                  ),
                ),
              ),
            ],
          ), context: context,
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

//  Future _modifyQuestion() async {
//
//    final result = await Navigator.push(
//      context,
//      MaterialPageRoute(
//          builder: (context) => ModifySubEx4Page(
//              document: newItems[_currentPage], userInfo: _userInfoController.userInfo)),
//    );
//    if (result) {
//      setState(() {
//      });
//    }
//  }

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
    var _num3 = 0.0;
    var _num4 = 0.0;
    String _score;
    var _qCnt = 0.0;

    for (var i = 0; i < _testResult.length; i++) {
      // i is students
      _qCnt += _testResult[i]['question_cnt'].toDouble();
    }
    _qCnt = _qCnt / _testResult.length.toDouble();

//  if (_testResult.length == 0) {
    if (_testResult.isEmpty) {
      _score = _multiMsg.strNoOne;
    } else if (_qCnt < newItems.length.toDouble()) {
      _score = '${_multiMsg.strMissMatching} ' + _qCnt.toString() + ')';
    } else {
      for (var i = 0; i < _testResult.length; i++) { //_testResult.length = how many students
        // i is students
        if (_testResult[i]['student'][_currentPage] == 1) _num1 += 1;
        if (_testResult[i]['student'][_currentPage] == 2) _num2 += 1;
        if (_testResult[i]['student'][_currentPage] == 3) _num3 += 1;
        if (_testResult[i]['student'][_currentPage] == 4) _num4 += 1;
      }
      _num1 = _num1 / _testResult.length * 100;
      _num2 = _num2 / _testResult.length * 100;
      _num3 = _num3 / _testResult.length * 100;
      _num4 = _num4 / _testResult.length * 100;

      _score = 'selection - ';
      _score += '#1(' + _num1.toStringAsFixed(0) + '%)';
      _score += '  #2(' + _num2.toStringAsFixed(0) + '%)';
      _score += '  #3(' + _num3.toStringAsFixed(0) + '%)';
      _score += '  #4(' + _num4.toStringAsFixed(0) + '%)';
    }

    _textController1.text = newItems[_currentPage]['ex1'];
    _textController2.text = newItems[_currentPage]['ex2'];
    _textController3.text = newItems[_currentPage]['ex3'];
    _textController4.text = newItems[_currentPage]['ex4'];
    _checkboxValue1 = newItems[_currentPage]['correct1'];
    _checkboxValue2 = newItems[_currentPage]['correct2'];
    _checkboxValue3 = newItems[_currentPage]['correct3'];
    _checkboxValue4 = newItems[_currentPage]['correct4'];

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(8.0)),
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: Text(
                newItems[_currentPage]['contents'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                width: 500,
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                )),
            Padding(padding: EdgeInsets.all(4.0)),
            CarouselSlider.builder(
              itemCount: newItems.length,
              itemBuilder: (context, index, realIdx) {
                if (_deleteFlag == true) {
                  _deleteFlag = false;
                  index = 0;
                }
                return Container(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
//                  color: Colors.pinkAccent,
                  child: Column(
                    children: <Widget>[
                      Container(
//                        decoration: BoxDecoration(
//                            border: Border.all(color: Colors.redAccent)
//                        ),
                        child: newItems[index]['photoUrl'] == 'NoImage' ?
                        Container(
                            width: 350,
                            height: 20,
                            child: null
                        ) :
                        Container(
                            width: 350,
                            height: 200,
                            child: Image.network(newItems[index]['photoUrl'],
                                fit: BoxFit.cover) //, width: 1000)
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 45,
                              child: Checkbox(
                                value: _checkboxValue1,
                                onChanged: null, //(bool value) {},
                              ),
                            ),
                            Flexible(
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(12.0),
                                    border: OutlineInputBorder(),
                                    labelText: '${_multiMsg.strEx}1)'),
                                controller: _textController1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(4.0)),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 45,
                              child: Checkbox(
                                value: _checkboxValue2,
                                onChanged: null, //(bool value) {},
                              ),
                            ),
                            Flexible(
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(12.0),
                                    border: OutlineInputBorder(),
                                    labelText: '${_multiMsg.strEx}2)'),
                                controller: _textController2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(4.0)),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 45,
                              child: Checkbox(
                                value: _checkboxValue3,
                                onChanged: null, //(bool value) {},
                              ),
                            ),
                            Flexible(
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(12.0),
                                    border: OutlineInputBorder(),
                                    labelText: '${_multiMsg.strEx}3)'),
                                controller: _textController3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(4.0)),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 45,
                              child: Checkbox(
                                value: _checkboxValue4,
                                onChanged: null, //(bool value) {},
                              ),
                            ),
                            Flexible(
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(12.0),
                                    border: OutlineInputBorder(),
                                    labelText: '${_multiMsg.strEx}4)'),
                                controller: _textController4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Text(
                          '${_multiMsg.strStudentCnt}: ${_testResult.length.toString()}'),
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