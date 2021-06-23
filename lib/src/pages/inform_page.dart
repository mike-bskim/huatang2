import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'dart:async';

import 'package:huatang2/src/model/multi_msg.dart';


class InformPage extends StatefulWidget {

  @override
  _InformPageState createState() => _InformPageState();
}

class _InformPageState extends State<InformPage> {
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  final _textController1 = TextEditingController();
  var _userType = ['Teacher', 'Student'];
  var _selectedUserType;
  var _selectedUserTypeForDB;
  final _langType = ['한글', 'English', '中文'];
  var _selectedLangType;
  var _selectedLangTypeForDB;
  int? qTotal;
  var _multiMsg;

  @override
  void initState() {
    // 생성자 다음에 초기화 호출 부분, 변수 초기화 용도
    // TODO: implement initState
    super.initState();
    _multiMsg = MultiMessageInform();
    _multiMsg.convertDescription('English');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    _textController1.text = _multiMsg.strAppBarTitle;
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(true);
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
                      Text('${_multiMsg.strLang}: '),
                      SizedBox(
                        width: 20,
                        child: Container(),),
                      DropdownButton<String>(
                        onChanged: (String? value) => popupLangTypeSelected(value!),
                        value: _selectedLangType,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        items: _langType.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(15.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${_multiMsg.strUserType}: '),
                      SizedBox(
                        width: 20,
                        child: Container(),),
                      DropdownButton<String>(
                        onChanged: (String? value) => popupUserTypeSelected(value!),
                        value: _selectedUserType,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        items: _userType.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(15.0)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      if(_selectedUserType != null && _selectedLangType != null) {
                        _saveUserInfo();
                      }
                    },
                    child: Text(_multiMsg.strApply),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void popupUserTypeSelected(String value) {
    print('popup user: ' + value.toString());
    setState(() {
      _selectedUserType = value;

      if(_selectedUserType == '선생님' || _selectedUserType == 'Teacher'
          || _selectedUserType == '老师') {
        _selectedUserTypeForDB = 'Teacher';
      }
      else if(_selectedUserType == '학생' || _selectedUserType == 'Student'
          || _selectedUserType == '学生') {
        _selectedUserTypeForDB = 'Student';
      }
    });
  }

  void popupLangTypeSelected(String value) {
    print('popup lang: ' + value.toString());
    setState(() {
      _selectedLangType = value;
      _selectedUserType = null;
      if(_selectedLangType == '한글') {
        _selectedLangTypeForDB = 'Korean';
        _multiMsg.convertDescription(_selectedLangTypeForDB);
        _userType = ['선생님', '학생'];
      }
      else if(_selectedLangType == 'English') {
        _selectedLangTypeForDB = 'English';
        _multiMsg.convertDescription(_selectedLangTypeForDB);
        _userType = ['Teacher', 'Student'];
      }
      else if(_selectedLangType == '中文') {
        _selectedLangTypeForDB = 'Chinese';
        _multiMsg.convertDescription(_selectedLangTypeForDB);
        _userType = ['老师', '学生'];
      }
      else {
        _selectedLangTypeForDB = 'Other';
      }
    });
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
      'user_type': _selectedUserTypeForDB,
      'exp_date': _nextMonth[0],
      'validation': false,
      'language' : _selectedLangTypeForDB,
      'last_login' : '',
      'app_version': '',
      'login_cnt': 0,
    }).then((onValue) {
      var _mapUserInfo = {
        'user_type' : _selectedUserTypeForDB,
        'language' : _selectedLangTypeForDB,
        'complete' : 'OK',
      };
//      Navigator.pop(context, _mapUserInfo);
      Get.back(result: _mapUserInfo);

    });
  }

}
