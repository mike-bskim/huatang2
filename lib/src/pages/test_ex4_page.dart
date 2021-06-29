import 'dart:async';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/component/dialog_component.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/model/admob_flutter_ads.dart';
import 'package:huatang2/src/model/multi_msg.dart';

enum studentSelect { one, two, three, four }

//
class TestEx4Page extends StatefulWidget {
  final _testUserInfo;
//  final userInfo;
  TestEx4Page(this._testUserInfo); // , this.userInfo

  @override
  _TestEx4PageState createState() => _TestEx4PageState();
}

class _TestEx4PageState extends State<TestEx4Page> {
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  int _currentPage = 0;
  final Map _answerHistory = {};
  final Map _studentInfo = {};
  var newItems = [];
  var qTotal = 0;
  var _multiMsg;
  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();
  final _textController3 = TextEditingController();
  final _textController4 = TextEditingController();

  studentSelect? _studentSelect;

  /* ********************* adMob ********************* */
  late AdMobManager _adMobManager;
  late AdmobInterstitial _adMobInterstitial;
//  String _appId;
  late String _adUnitId;
  /* ********************* adMob ********************* */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _multiMsg = MultiMessageTestEx4();
    _getSubCnt();
    _studentInfo['studentName'] = widget._testUserInfo['studentName'];
    _studentInfo['studentUid'] = widget._testUserInfo['studentUid'];
    _studentInfo['userType'] = widget._testUserInfo['userType'];
    _studentInfo['studentEmail'] = widget._testUserInfo['studentEmail'];
    _studentInfo['chapterPhotoUrl'] = widget._testUserInfo['chapterPhotoUrl'];
    _studentInfo['previous'] = widget._testUserInfo['previous'];
    /* ********************* adMob ********************* */
    _adMobManager = AdMobManager();
//    _appId = _adMobManager.getAppId();
    _adUnitId = _adMobManager.getAdUnitId();
    _adMobInterstitial = createInterstitial();
    /* ********************* adMob ********************* */
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

  /* ********************* adMob ********************* */
  AdmobInterstitial createInterstitial() { // 전면광고 testID(ca-app-pub-3940256099942544/1033173712)
    return AdmobInterstitial(adUnitId: _adUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if(event == AdmobAdEvent.loaded) {
          print('****************************************_adUnitId(loaded): ' + _adUnitId.toString());
          print('****************************************_adUnitId(event): ' + event.toString());
          _adMobInterstitial.show();
        }
        else if(event == AdmobAdEvent.closed) {
          print('****************************************_adUnitId(closed): ' + _adUnitId.toString());
          print('****************************************_adUnitId(event): ' + event.toString());
          _adMobInterstitial.dispose();
        }
      },
    );
  }
  /* ********************* adMob ********************* */

  @override
  Widget build(BuildContext context) {
    _multiMsg.convertDescription(_userInfoController.userInfo['userLangType']);

    if (_answerHistory.isNotEmpty) {
      if (_answerHistory[_currentPage] == 1) {
        _studentSelect = studentSelect.one;
      } else if (_answerHistory[_currentPage] == 2) {
        _studentSelect = studentSelect.two;
      } else if (_answerHistory[_currentPage] == 3) {
        _studentSelect = studentSelect.three;
      } else if (_answerHistory[_currentPage] == 4) {
        _studentSelect = studentSelect.four;
      } else {
        _studentSelect = null;
      }
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          backgroundColor: Color.fromRGBO(38, 100, 100, 1.0),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        actions: <Widget>[
        PopupMenuButton<int>(
          icon: Icon(Icons.sort),
          onSelected: (value) {
            if (value == 0) {
              _checkResultDialog(); //_showResult();
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(value: 0, child: Text(_multiMsg.strSubmit)),
            ];
          },
        )
        ],
        title: Text((_currentPage + 1).toString() + ' / ' + qTotal.toString(),
               style: TextStyle(color: Colors.white54),
        )
      ),
      body: _buildBody());
  }

//.whereEqualTo("email", widget.user.email)
  Widget _buildBody() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection(widget._testUserInfo['teacherUid']) // post, teacher
        .doc(widget._testUserInfo['chapterCode']) // question id
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
        return Text(_multiMsg.strNoTest);
      },
    );
  }

  void radioChanged(studentSelect? value) {
    setState(() {
      _studentSelect = value;
      _answerHistory.putIfAbsent(_currentPage, () => 0);
      if (_studentSelect == studentSelect.one) {
        _answerHistory[_currentPage] = 1;
      } else if (_studentSelect == studentSelect.two) {
        _answerHistory[_currentPage] = 2;
      } else if (_studentSelect == studentSelect.three) {
        _answerHistory[_currentPage] = 3;
      } else {
        _answerHistory[_currentPage] = 4;
      }
    });
  }

  void _getSubCnt() {
    FirebaseFirestore.instance
      .collection(widget._testUserInfo['teacherUid']) // post
      .doc(widget._testUserInfo['chapterCode'])
      .collection('post_sub')
      .get()
      .then((snapShot) {
      setState(() {
        qTotal = snapShot.docs.length;
      });
    });
  }

  Future<void> _checkResultDialog() async {
    var _errorFlag = false;
    var _msg;
    var _answerCnt = _answerHistory.length;

    if (qTotal != _answerCnt) {
      _errorFlag = true;
      _msg = _multiMsg.strWarnQuestion;
    }

    if (_errorFlag == true) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return WarningNotice(title: _multiMsg.strWarnMessage, msg: _msg, btnMsg: _multiMsg.strOk,);
//          return AlertDialog(
//            title: Text(_multiMsg.strWarnMessage),
//            content: SingleChildScrollView(
//              child: ListBody(
//                children: <Widget>[
//                  Text(_msg),
//                ],
//              ),
//            ),
//            actions: <Widget>[
//              TextButton(
//                onPressed: () {
//                  Navigator.of(context).pop(false);
//                },
//                child: Text(_multiMsg.strOk),
//              ),
//            ],
//          );
        },
      );
    } else {
      /* ********************* adMob ********************* */
      _adMobInterstitial.load();
      /* ********************* adMob ********************* */
      await _showResult();
    }
  }

  Future _showResult() async {

//    final result = await Navigator.push(
//      context,
//      MaterialPageRoute(
//        builder: (context) => ResultEx4Page(newItems, _answerHistory, _studentInfo, widget.userInfo),
//      ),
//    );
//    if (result) {
//      setState(() {});
//    }
  }

  Widget _buildCarouselSlider(List newItems) {

    _textController1.text = newItems[_currentPage]['ex1'];
    _textController2.text = newItems[_currentPage]['ex2'];
    _textController3.text = newItems[_currentPage]['ex3'];
    _textController4.text = newItems[_currentPage]['ex4'];

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
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
                )
            ),
            Padding(padding: EdgeInsets.all(4.0)),
            CarouselSlider.builder(
              itemCount: newItems.length,
              itemBuilder: (context, index, realIdx) {
                return Container(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: Column(
                    children: <Widget>[
                      Container(
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
                                fit: BoxFit.cover) //(, width: 1000)
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 45,
                                  child: Radio(
                                      value: studentSelect.one,
                                      groupValue: _studentSelect,
                                      onChanged: radioChanged),
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
                            Padding(padding: EdgeInsets.all(4.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 45,
                                  child: Radio(
                                      value: studentSelect.two,
                                      groupValue: _studentSelect,
                                      onChanged: radioChanged),
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
                            Padding(padding: EdgeInsets.all(4.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 45,
                                  child: Radio(
                                      value: studentSelect.three,
                                      groupValue: _studentSelect,
                                      onChanged: radioChanged),
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
                            Padding(padding: EdgeInsets.all(4.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 45,
                                  child: Radio(
                                      value: studentSelect.four,
                                      groupValue: _studentSelect,
                                      onChanged: radioChanged),
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
                          ],
                        ),
                      ),

                    ],
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

}
