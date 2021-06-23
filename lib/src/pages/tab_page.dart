import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/model/multi_msg.dart';
import 'package:huatang2/src/pages/home_page.dart';
import 'package:huatang2/src/pages/inform_page.dart';


class TabPage extends StatefulWidget {

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UserInfoController _userInfoController = Get.put(UserInfoController());

  int _selectedIndex = 0;
  List? _pages;

  @override
  void initState() {
    // 생성자 다음에 초기화 호출 부분, 변수 초기화 용도
    // TODO: implement initState
    super.initState();
    _pages = [
//      HomePage(widget.user, this._userInfo),
      HomePage(),
      Text('StudyPage'),
      Text('ManagePage'),
      Text('TestPage'),
//      StudyPage(widget.user, this._userInfo),
//      ManagePage(widget.user, this._userInfo),
//      TestMainPage(widget.user, this._userInfo),
    ];
    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    print('tabPage build');

    return Scaffold(
      body: Center(child: _pages![_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(38, 100, 100, 1.0),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          // This is all you need!
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: ('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.edit),
                label: ('Study')),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: ('Manage')),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_travel),
                label: ('Test')),
          ]),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _getUserInfo() {
//    print('_getUserInfo:' + _userInfoController.userInfo.toString());
//    print(_userInfoController.userInfo['uid']);

    FirebaseFirestore.instance
        .collection('user_info')
        .doc(_userInfoController.userInfo['uid']) // .doc(widget.user.uid)
        .get()
        .then((doc) async {
      if (doc.exists) { // 기 사용자 확인
        var _data = doc.data();
//        print('old user: ' + _data.toString());

        if (_data!['language'] == null) { // 추가정보 누락자.
//            var result1 = await Navigator.push(context,
//              MaterialPageRoute(builder: (context) => InformPage(widget.user))
//            );
          print('old user: ' + _data.toString());
          final result1 = await Get.to(InformPage()); //widget.user
          print('result1: ' + result1.toString());

          try {
            if (result1['complete'] == null) { // 정보입력이 완료되지 않음
              await FirebaseAuth.instance.signOut();
              await _googleSignIn.signOut();
            }
            else { // 정보입력이 완료
              _userInfoController.mappingUserType(
                  userType: result1['user_type'], userLangType: result1['language']);
            }
          } catch (error) { // 정보입력이 완료되지 않음
            await FirebaseAuth.instance.signOut();
            await _googleSignIn.signOut();
          }
        } else {
          _userInfoController.mappingUserType(
              userType: _data['user_type'], userLangType: _data['language']);
          await _saveUserLoginInfo();
        }
      } else { // 신규 사용자 등록시
        print('new user: ');
        // doc.data() will be undefined in this case
        var result = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => InformPage()) // widget.user
        );
        try {
          if (result['complete'] == null) { // 정보입력이 완료되지 않음
            await FirebaseAuth.instance.signOut();
            await _googleSignIn.signOut();
          }
          else { // 정보입력이 완료
            _userInfoController.mappingUserType(
                userType: result['user_type'], userLangType: result['language']);
          }
        } catch (error) { // 정보입력이 완료되지 않음
          await FirebaseAuth.instance.signOut();
          await _googleSignIn.signOut();
        }
      }

      setState(() {
        _pages = [
          HomePage(), // widget.user, this._userInfo
          Text('StudyPage'),
          Text('ManagePage'),
          Text('TestPage'),
//            StudyPage(widget.user, this._userInfo),
//            ManagePage(widget.user, this._userInfo),
//            TestMainPage(widget.user, this._userInfo),
        ];
      });
    });
  }

  Future _saveUserLoginInfo() async {
    var _userInfo = FirebaseFirestore.instance
        .collection('user_info')
        .doc(_userInfoController.userInfo['uid']); // post collection 만들고, 하위에 문서를 만든다 widget.user.uid

    var _date = DateTime.now();

    await _userInfo.update({
      'last_login': _date.toString(),
      'app_version': MultiMessageHome.version,
      'login_cnt': FieldValue.increment(1),
    }).then((onValue) {});
  }

}
