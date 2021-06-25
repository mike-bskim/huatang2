import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/controller/dropdown_button_controller.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'dart:async';

class InformPage extends StatefulWidget {

  @override
  _InformPageState createState() => _InformPageState();
}

class _InformPageState extends State<InformPage> {
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  final DropdownButtonController _dropdownButtonController = Get.put(DropdownButtonController());
  var _textController1;

  @override
  void initState() {
    // 생성자 다음에 초기화 호출 부분, 변수 초기화 용도
    _textController1 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('InformPage >> build');

    return Scaffold(
      body: Obx(()=>_buildBody()),
    );
  }

  Widget _buildBody() {
    _textController1.text = _dropdownButtonController.multiMsg['strAppBarTitle'];
    return WillPopScope(
      onWillPop: () {
//        Navigator.of(context).pop(true);
        Get.back(result: true);
        return Future.value(true);
      },
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(15.0)),
              TextField(
                enabled: false,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                controller: _textController1,
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${_dropdownButtonController.multiMsg['strLang']}: '),
                      SizedBox(
                        width: 20,
                        child: Container(),),
                      DropdownButtonLangType(),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(15.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${_dropdownButtonController.multiMsg['strUserType']}: '),
                      SizedBox(
                        width: 20,
                        child: Container(),),
                      DropdownButtonUserType(),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(15.0)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      _saveUserInfo();
                    },
                    child: Text(_dropdownButtonController.multiMsg['strApply']),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _saveUserInfo() async {

    var _userInfo = FirebaseFirestore.instance
      .collection('user_info')
      .doc(_userInfoController.userInfo['uid']); // post collection 만들고, 하위에 문서를 만든다 widget.user.uid

    var _date = DateTime.now();
    var _nextMonth = DateTime(_date.year, _date.month+1, _date.day).toString().split(' ');

    await _userInfo.set({
      'datetime' : _date.toString(),
      'id': _userInfo.id,
      'email': _userInfoController.userInfo['email'], // widget.user.email
      'user_type': _dropdownButtonController.selectedUserTypeForDB,
      'exp_date': _nextMonth[0],
      'validation': false,
      'language' : _dropdownButtonController.selectedLangTypeForDB,
      'last_login' : '',
      'app_version': '',
      'login_cnt': 0,
      'providerId': _userInfoController.userInfo['providerId'],
      's_uid': _userInfoController.userInfo['s_uid'],
    }).then((onValue) {
      var _mapUserInfo = {
        'user_type' : _dropdownButtonController.selectedUserTypeForDB,
        'language' : _dropdownButtonController.selectedLangTypeForDB,
        'complete' : 'OK',
      };
      Get.back(result: _mapUserInfo);
      // Navigator.pop(context, _mapUserInfo);
    });
  }

}
