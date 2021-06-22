import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

import 'package:huatang2/src/model/multi_msg.dart';


class InformPage extends StatefulWidget {
  final user;

  InformPage(this.user);

  @override
  _InformPageState createState() => _InformPageState();
}

class _InformPageState extends State<InformPage> {
  final _textController1 = new TextEditingController();
  var _userType = ['Teacher', 'Student'];
  var _selectedUserType;
  var _selectedUserTypeForDB;
  var _langType = ['한글', 'English', '中文'];
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
                    child: Text(_multiMsg.strApply),
//                    color: Colors.blueAccent,
//                    textColor: Colors.white,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      if(this._selectedUserType != null && this._selectedLangType != null) {
                        _saveUserInfo();
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onWillPop: () {
        Navigator.of(context).pop(true);
        return Future.value(true);
      },
    );
  }

  void popupUserTypeSelected(String value) {
    print('popup user: ' + value.toString());
    setState(() {
      this._selectedUserType = value;

      if(this._selectedUserType == '선생님' || this._selectedUserType == 'Teacher'
          || this._selectedUserType == '老师') {
        this._selectedUserTypeForDB = 'Teacher';
      }
      else if(this._selectedUserType == '학생' || this._selectedUserType == 'Student'
          || this._selectedUserType == '学生') {
        this._selectedUserTypeForDB = 'Student';
      }
    });
  }

  void popupLangTypeSelected(String value) {
    print('popup lang: ' + value.toString());
    setState(() {
      this._selectedLangType = value;
      _selectedUserType = null;
      if(this._selectedLangType == '한글') {
        this._selectedLangTypeForDB = 'Korean';
        _multiMsg.convertDescription(this._selectedLangTypeForDB);
        _userType = ['선생님', '학생'];
      }
      else if(this._selectedLangType == 'English') {
        this._selectedLangTypeForDB = 'English';
        _multiMsg.convertDescription(this._selectedLangTypeForDB);
        _userType = ['Teacher', 'Student'];
      }
      else if(this._selectedLangType == '中文') {
        this._selectedLangTypeForDB = 'Chinese';
        _multiMsg.convertDescription(this._selectedLangTypeForDB);
        _userType = ['老师', '学生'];
      }
      else {
        this._selectedLangTypeForDB = 'Other';
      }
    });
  }

  Future _saveUserInfo() async {
    var _userInfo = FirebaseFirestore.instance
      .collection('user_info')
      .doc(widget.user.uid); // post collection 만들고, 하위에 문서를 만든다

    var _date = DateTime.now();
    var _nextMonth = DateTime(_date.year, _date.month+1, _date.day).toString().split(' ');

    _userInfo.set({
      'datetime' : _date.toString(),
      'id': _userInfo.id,
      'email': widget.user.email,
      'user_type': this._selectedUserTypeForDB,
      'exp_date': _nextMonth[0],
      'validation': false,
      'language' : this._selectedLangTypeForDB,
      'last_login' : '',
      'app_version': '',
      'login_cnt': 0,
    }).then((onValue) {
      var _mapUserInfo = {
        'user_type' : this._selectedUserTypeForDB,
        'language' : this._selectedLangTypeForDB,
        'complete' : 'OK',
      };
      Navigator.pop(context, _mapUserInfo);
    });
  }

}
