import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/model/multi_msg.dart';


// stless
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  var _multiMsg;
  var _userTypeMsg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _multiMsg = MultiMessageHome();
  }

  @override
  Widget build(BuildContext context) {
    if(_userInfoController.userInfo['userLangType'] != null) {
      _multiMsg.convertDescription(_userInfoController.userInfo['userLangType']);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(38, 100, 100, 1.0),
        title: Text(_multiMsg.strVersion, //'Version 0.2.9',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white,),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              _googleSignIn.signOut();
              FacebookAuth.instance.logOut();
            })
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if(_userInfoController.userInfo['userType'] == 'Teacher') {
      _userTypeMsg = _multiMsg.strTeacher;
    } else if(_userInfoController.userInfo['userType'] == 'Parents') {
      _userTypeMsg = _multiMsg.strParents;
    } else if(_userInfoController.userInfo['userType'] == 'Student') {
      _userTypeMsg = _multiMsg.strStudent;
    } else {
      _userTypeMsg = _multiMsg.strOther;
    }
    return Container(
//      color: Colors.amber,
      padding: EdgeInsets.all(24.0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Welcome to Play',
                      style: TextStyle(
                        fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Icon(Icons.local_library, size: 25, color: Colors.black38,),
                    ),
                    Text('Study',
                      style: TextStyle(
                        fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                Text(_userTypeMsg),
                Padding(padding: EdgeInsets.all(16.0)),
                SizedBox(
                  width: 260.0,
                  child: Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Obx(
                        ()=>Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(8.0)),
                            SizedBox(
                              width: 80.0,
                              height: 80.0,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(_userInfoController.userInfo['photoURL']),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(8.0)),
                            Text(_userInfoController.userInfo['email']?? ' ', style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(_userInfoController.userInfo['displayName']?? ' '),
                            Padding(padding: EdgeInsets.all(8.0)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
//                ElevatedButton(
//                    onPressed: () {
//                      _userInfoController.userInfo['displayName'] = 'aa';
//                      print('변경후 이름: ' + _userInfoController.userInfo['displayName'].toString());
//                      },
//                    child: Text('이름변경'),
//                ),
              ],
            ),
          ),
        )
      ),
    );
  }

}
