
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/model/multi_msg.dart';
import 'package:huatang2/src/pages/home_page.dart';
import 'package:huatang2/src/pages/inform_page.dart';
//import 'home_page.dart';
//import 'inform_page.dart';
//import 'manage_page.dart';
//import 'study_page.dart';
//import 'test_main_page.dart';
//import 'package:google_sign_in/google_sign_in.dart';

//import 'multi_msg.dart';

class TabPage extends StatefulWidget {

  final user;
  TabPage(this.user);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UserInfoController _userInfoController = Get.put(UserInfoController());

  int _selectedIndex = 0;
  List? _pages;
  Map _userInfo = {
    'userType' : 'Others',
    'userLangType' : '',
  };

  @override
  void initState() { // 생성자 다음에 초기화 호출 부분, 변수 초기화 용도
    // TODO: implement initState
    super.initState();
    _pages = [
      HomePage(widget.user, this._userInfo),
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
//    print(_userInfoController.userInfo);

    return Scaffold(
      body: Center(child: _pages![_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(38, 100, 100, 1.0),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // This is all you need!
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

    FirebaseFirestore.instance
      .collection('user_info')
      .doc(_userInfoController.userInfo['uid']) // .doc(widget.user.uid)
      .get()
      .then((doc) async {
        if (doc.exists) { // 기 사용자 확인
          var _email = doc.data();
          this._userInfo['userType'] = _email!['user_type'];
          this._userInfo['userLangType'] = _email['language'];
//          print('old user: ' + _email.toString());

          if (_email['language'] == null) { // 추가정보 누락자.
            var result1 = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => InformPage(widget.user))
            );
            try{
              if(result1['complete'] == null) { // 정보입력이 완료되지 않음
                FirebaseAuth.instance.signOut();
                _googleSignIn.signOut();
              }
              else {// 정보입력이 완료
                this._userInfo['userType'] = result1['user_type'];
                this._userInfo['userLangType'] = result1['language'];
              }
            } catch (error) {// 정보입력이 완료되지 않음
              FirebaseAuth.instance.signOut();
              _googleSignIn.signOut();
            }
          } else {
            _saveUserLoginInfo();
          }
        } else { // 신규 사용자 등록시
          print('new user: ');
          // doc.data() will be undefined in this case
          var result = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => InformPage(widget.user))
          );
          try{
            if (result['complete'] == null) { // 정보입력이 완료되지 않음
              FirebaseAuth.instance.signOut();
              _googleSignIn.signOut();
            }
            else {// 정보입력이 완료
              this._userInfo['userType'] = result['user_type'];
              this._userInfo['userLangType'] = result['language'];
            }
          } catch (error) {// 정보입력이 완료되지 않음
            FirebaseAuth.instance.signOut();
            _googleSignIn.signOut();
          }
        }

        setState(() {
          _pages = [
            HomePage(widget.user, this._userInfo),
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
        .doc(widget.user.uid); // post collection 만들고, 하위에 문서를 만든다

    var _date = DateTime.now();

    _userInfo.update({
      'last_login' : _date.toString(),
      'app_version': MultiMessageHome.version,
      'login_cnt': FieldValue.increment(1),
    }).then((onValue) {
    });
  }

}
