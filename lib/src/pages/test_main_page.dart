import 'dart:async';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/component/common_component.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/model/admob_flutter_ads.dart';
import 'package:huatang2/src/model/multi_msg.dart';
import 'package:huatang2/src/pages/test_ex4_page.dart';

//
class TestMainPage extends StatefulWidget {

  @override
  _TestMainPageState createState() => _TestMainPageState();
}

class _TestMainPageState extends State<TestMainPage> {
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  var _textController1;
  var _textController2;
  var _textController3;
  var _studentUid;
  var _multiMsg;
  late bool _teacherUid;

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
    _textController1 = TextEditingController();
    _textController2 = TextEditingController();
    _textController3 = TextEditingController();
    _studentUid = 'other';
    _multiMsg = MultiMessageTestMain();

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

    if (_userInfoController.userInfo['userType'] == 'Teacher') {
      _studentUid = _userInfoController.userInfo['uid'];
      _textController1.text = _userInfoController.userInfo['uid'];
      _teacherUid = false;
    } else if (_userInfoController.userInfo['userType'] == 'Student') {
      _studentUid = _userInfoController.userInfo['uid'];
      _textController1.text = '';
      _teacherUid = true;
    }
    _textController2.text = '';
    _textController3.text = _userInfoController.userInfo['displayName'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(38, 100, 100, 1.0),
        title: Text(_multiMsg.strAppBarTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Test Page',
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: _checkTestPageDialog,
        child: Icon(Icons.pending_actions),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Flexible(
              child: TextField(
                enabled: _teacherUid,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: _multiMsg.strTeacherUid,
                ),
                controller: _textController1,
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Flexible(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: _multiMsg.strTestCode),
                controller: _textController2,
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Flexible(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: _multiMsg.strStudentName,
                ),
                controller: _textController3,
              ),
            ),
          ],
        )
    );
  }

  Future<void> _checkTestPageDialog() async {
    var _errorFlag = false;
    var _msg;

    if (_textController1.text.trim() == '') {
      _errorFlag = true;
      _msg = _multiMsg.strWarnUid;
    } else if (_textController2.text.trim() == '') {
      _errorFlag = true;
      _msg = _multiMsg.strWarnCode;
    }

    if (_errorFlag == true) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return WarningNotice(title: _multiMsg.strWarnMessage, msg: _msg, btnMsg: _multiMsg.strOk,);
        },
      );
    } else {
      /* ********************* adMob.load ********************* */
      _adMobInterstitial.load();
      /* ********************* adMob.load ********************* */
      await _loadQuestionType();
    }
  }

  Future _loadQuestionType() async {

    var _result;
    // ignore: omit_local_variable_types
    Map _testUserInfo = {};

    await FirebaseFirestore.instance
      .collection(_textController1.text)
      .doc(_textController2.text,) // chapter_code
      .get()
      .then((doc) {
      if (doc.exists) {
        _result = doc.data();

        _testUserInfo['teacherUid'] = _textController1.text;
        _testUserInfo['chapterCode'] = _textController2.text; //code
        _testUserInfo['studentName'] = _textController3.text;
        _testUserInfo['studentUid'] = _studentUid;
        _testUserInfo['userType'] = _userInfoController.userInfo['userType'];
        _testUserInfo['studentEmail'] = _userInfoController.userInfo['email'];
        _testUserInfo['chapterPhotoUrl'] = _result['photoUrl'];
        _testUserInfo['previous'] = 'test';

        if(_result['question_type'] == 'ex2') {
//          Navigator.push(context, MaterialPageRoute(builder: (context) {
//            return TestEx2Page(_testUserInfo, widget.userInfo);
//          }));
        }
        else if(_result['question_type'] == 'ex4') {
//          Navigator.push(context, MaterialPageRoute(builder: (context) {
//            return TestEx4Page(_testUserInfo); //, widget.userInfo
//          }));
          Get.to(()=> TestEx4Page(_testUserInfo));
        }
        else if(_result['question_type'] == 'matchPicture') {
//          Navigator.push(context, MaterialPageRoute(builder: (context) {
//            return TestMatch4Page(_testUserInfo, widget.userInfo);
//          }));
        }
        else if(_result['question_type'] == 'matchText') {
//          Navigator.push(context, MaterialPageRoute(builder: (context) {
//            return TestMatchTextPage(_testUserInfo, widget.userInfo);
//          }));
        }
        else if(_result['question_type'] == 'multiEx4') {
//          Navigator.push(context, MaterialPageRoute(builder: (context) {
//            return TestMultiEx4Page(_testUserInfo, widget.userInfo);
//          }));
        }
      } else {
        return Center(child: Text(_multiMsg.strNoData));

      }
      setState(() {
      });

    });
  }

}