import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/controller/study_info_controller.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/model/multi_msg.dart';
import 'package:huatang2/src/pages/create_chapter_page.dart';
import 'package:huatang2/src/pages/detail_study_page.dart';


//
class StudyPage extends StatefulWidget {

  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  final StudyInfoController _studyInfoController = Get.put(StudyInfoController());
  bool _teacherOnly = false;
  var _multiMsg;
//  bool _clickedFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_userInfoController.userInfo['userType'] == 'Teacher') {
      _teacherOnly = true;
    } else {
      _teacherOnly = false;
    }
    _multiMsg = MultiMessageStudy();
  }

  @override
  Widget build(BuildContext context) {
    _multiMsg.convertDescription(_userInfoController.userInfo['userLangType']); // widget._userInfo['userLangType']

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(38, 100, 100, 1.0),
        title: Text(_multiMsg.strAppBarTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: _teacherOnly ? _buildBody() : _notTeacher(),
      floatingActionButton: _teacherOnly ? FloatingActionButton(
        onPressed: () {
//          Navigator.push(context,
//            MaterialPageRoute(builder: (context) => CreateChapterPage())
//          );
          Get.to(() => CreateChapterPage());
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.school_outlined),
      ) : null,
    );
  }

//FirebaseFirestore.instance.collection('post').where('email', isEqualTo: widget.user.email)
  Widget _buildBody() {

    return StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection(_userInfoController.userInfo['uid']) // widget.user.uid
        .orderBy("datetime")
        .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        var items = snapshot.data.docs ?? []; // documents->docs
        if (items.length < 1) {
          return Center(child: Text(_multiMsg.strNoData));
        }

        _studyInfoController.chapterInfo.clear();

        for (var i = 0; i < items.length; i++) {
            if (items[i]['email'] == _userInfoController.userInfo['email']) { // widget.user.email
              _studyInfoController.chapterInfo.add(items[i]);
            }
        }

        return ListView.builder(
          itemCount: _studyInfoController.chapterInfo.length * 2, //8,
          padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
          itemBuilder: (context, index) {
            if(index.isOdd) return const Divider(color: Colors.grey);
            var realIndex = index ~/ 2;
            return _buildListItem(context, _studyInfoController.chapterInfo[realIndex]);
          }
        );
      },
    );
  }

  Widget _buildListItem(BuildContext context, chapterInfo) {

    var _questionType = 'N/A';
    if(chapterInfo['question_type'] == 'ex4') {
      _questionType = _multiMsg.strEx4;
    } else if(chapterInfo['question_type'] == 'ex2') {
      _questionType = _multiMsg.strTF;
    } else if(chapterInfo['question_type'] == 'matchPicture') {
      _questionType = _multiMsg.strMatchPicture;
    } else if(chapterInfo['question_type'] == 'matchText') {
      _questionType = _multiMsg.strMatchText;
    } else if(chapterInfo['question_type'] == 'multiEx4') {
      _questionType = _multiMsg.strMultiEx4;
    }

    var _createdDate = chapterInfo['datetime'].split(' ');
    var _questionCnt = 0;
    if (chapterInfo['question_cnt'] != null) {
      _questionCnt = chapterInfo['question_cnt'];
    }

    // 좋아요 기능을 나중에 추가해서 예외처리 로직을 추가함.
    var _favoriteCnt = 0;
    try{
      if (chapterInfo['favorite'] != null) {
        _favoriteCnt = chapterInfo['favorite'].length;
      } else {
        _favoriteCnt = 0;
      }

    } catch (e) {
      _favoriteCnt = 0;
    }

    return Hero(
      tag: chapterInfo['photoUrl'],
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () { // teacher case
//            Navigator.push(context, MaterialPageRoute(builder: (context) {
//              return DetailStudyPage(chapterInfo);//, widget._userInfo); //TabPage(widget.user);
//            }));
            Get.to(() => DetailStudyPage(chapterInfo));
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 120,
                  height: 90,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 120,
                        height: 90,
                        child: Image.network(chapterInfo['photoUrl'], fit: BoxFit.cover)
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.black54,
                          width: 70.0,
                          height: 20.0,
                          child: Text('${_multiMsg.strQCnt} : $_questionCnt',
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        )
                      ),
                      Container(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            alignment: Alignment.center,
//                              color: Colors.black54,
                            width: 30.0,
                            height: 30.0,
                            child: Stack(
                              children: [
                                Center(
                                  child: Icon(Icons.favorite, color: Colors.pink,),
                                ),
                                Center(
                                  child: Text('$_favoriteCnt',
                                    style: TextStyle(fontSize: 9, color: Colors.white),),
                                ),
                              ],
                            ),
                          )
                      ),
                    ]
                  )
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text('${_multiMsg.strTitle}: ' + chapterInfo['contents'], //_contentsTemp,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(top: 4.0)),
                        Container(
                          child: Text('${_multiMsg.strQType} : $_questionType', style: TextStyle(fontSize: 13))
                        ),
                        Padding(padding: const EdgeInsets.only(top: 4.0)),
                        SelectableText('${_multiMsg.strTestCode}: ' + chapterInfo['id'], style: TextStyle(fontSize: 10)),
                        Padding(padding: const EdgeInsets.only(top: 4.0)),
                        Text('${_multiMsg.strCreated} : ${_createdDate[0]}', style: TextStyle(fontSize: 10)),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _notTeacher() {
//    return Center(
//      child: Container(
//        child: Text(_multiMsg.strNotice),
//      ),
//    );

    return StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection('student')
        .doc(_userInfoController.userInfo['uid']) // widget.user.uid
        .collection(_userInfoController.userInfo['uid']) // widget.user.uid
        .orderBy('datetime')
        .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var items = snapshot.data.docs ?? []; // documents->docs
        if (items.length < 1) {
          return Text(_multiMsg.strNoData);
        }

        var newItems = [];

        for (var i = 0; i < items.length; i++) {
          if (items[i]['email'] == _userInfoController.userInfo['email']) { // widget.user.email
            newItems.add(items[i]);
          }
        }

        return ListView.builder(
          itemCount: newItems.length * 2, //8,
          padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
          itemBuilder: (context, index) {
            if(index.isOdd) return const Divider(color: Colors.grey);
            var realIndex = index ~/ 2;
            return _buildStudentTestListItem(context, newItems[realIndex]);
          }
        );
      },
    );
  }


  Widget _buildStudentTestListItem(BuildContext context, student_test_result) {

    var _questionType = 'N/A';
    if(student_test_result['question_type'] == 'ex4') {
      _questionType = _multiMsg.strEx4;
    } else if(student_test_result['question_type'] == 'ex2') {
      _questionType = _multiMsg.strTF;
    } else if(student_test_result['question_type'] == 'matchPicture') {
      _questionType = _multiMsg.strMatchPicture;
    } else if(student_test_result['question_type'] == 'matchText') {
      _questionType = _multiMsg.strMatchText;
    }

    var _createdDate = student_test_result['datetime'].split(' ');
    var _questionCnt = 0;
    if (student_test_result['question_cnt'] != null) {
      _questionCnt = student_test_result['question_cnt'];
    }

    var _imageTemp = _getImageNetwork(student_test_result['chapterPhotoUrl']);

    var _studentInfo = {};

    _studentInfo['teacherUid'] = student_test_result['teacher_uid'];
    _studentInfo['chapterCode'] = student_test_result['chapter_code']; //code
    _studentInfo['studentName'] = student_test_result['student_name'];
    _studentInfo['studentUid'] = student_test_result['student_uid'];
    _studentInfo['userType'] = _userInfoController.userInfo['userType'];
    _studentInfo['studentEmail'] = student_test_result['email'];
    _studentInfo['chapterPhotoUrl'] = student_test_result['chapterPhotoUrl'];
    _studentInfo['previous'] = 'study';

    var _answerHistory = student_test_result['student'];
    var _favorite = <String, dynamic>{};

    try{
      if(student_test_result['favorite'] != null) { // 정보입력이 완료되지 않음
//        _clickedFavorite = document['favorite'];
        _favorite[student_test_result['chapter_code']] = student_test_result['favorite'];
      }
    } catch (error) {// 정보입력이 완료되지 않음
//      _clickedFavorite = false;
      _favorite[student_test_result['chapter_code']] = false;
    }

    return Hero(
      tag: student_test_result['chapterPhotoUrl'],
      child: InkWell(
        onTap: () { // student case
//          _clickedFavorite = document['favorite'];
//          print('(document[favorite]' + document['student_uid'] +' / '+ document['chapter_code']+'/'+ _clickedFavorite.toString());
//          return checkStudyResult(document, _answerHistory, _studentInfo, widget._userInfo);
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                    width: 120,
                    height: 90,
                    child: Stack(
                        children: <Widget>[
                          Container(
                              width: 120,
                              height: 90,
                              child: _imageTemp,
                          ),
                          Container(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.black54,
                                width: 70.0,
                                height: 20.0,
                                child: Text('${_multiMsg.strQCnt} : $_questionCnt',
                                    style: TextStyle(fontSize: 10, color: Colors.white)),
                              )
                          ),

                          Container(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                alignment: Alignment.topRight,
                                width: 35.0,
                                height: 35.0,
                                child: IconButton(
                                  onPressed: (){
//                                    print('click icons - ' + document['chapter_code'] +' / '+ document['teacher_uid']);
                                    _toggleFavorite(student_test_result, _favorite);
                                  },
                                  icon: Icon(
                                    _favorite[student_test_result['chapter_code']] ? Icons.favorite : Icons.favorite_border,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                          ),

                        ]
                    )
                ),
                Expanded(
                  child: Container(
//                    width: 240,
                    height: 90,
                    color: Colors.amber,
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Text('${_multiMsg.strTitle}: ' + student_test_result['chapter_title'],
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(top: 8.0)),
                        Container(
                            child: Text('${_multiMsg.strQType} : $_questionType', style: TextStyle(fontSize: 13))
                        ),
//                        Padding(padding: const EdgeInsets.only(top: 4.0)),
//                        SelectableText('${_multiMsg.strTestCode}: ' + document['chapter_code'], style: TextStyle(fontSize: 10)),
                        Padding(padding: const EdgeInsets.only(top: 8.0)),
                        Text('${_multiMsg.strTestDate} : ${_createdDate[0]}', style: TextStyle(fontSize: 10)),

                      ],
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(right: 16.0))
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*
    _studentInfo['teacherUid'] = document['teacher_uid'];
    _studentInfo['chapterCode'] = document['chapter_code']; //code
    _studentInfo['studentName'] = document['student_name'];
    _studentInfo['studentUid'] = document['student_uid'];
    _studentInfo['userType'] = widget._userInfo['userType'];
    _studentInfo['studentEmail'] = document['email'];
    _studentInfo['chapterPhotoUrl'] = document['chapterPhotoUrl'];
    _studentInfo['previous'] = 'study';
  * */

  Future _toggleFavorite(document, Map _favorite) async {

    if(_favorite[document['chapter_code']] == true){
      _favorite[document['chapter_code']] = false;
    } else {
      _favorite[document['chapter_code']] = true;
    }

//    print('in _toggleFavorite:' + _favorite[document['chapter_code']].toString());

    //  history on the students result
    var doc = FirebaseFirestore.instance
        .collection('student') // post
        .doc(document['student_uid'])
        .collection(document['student_uid']) // post
        .doc(document['chapter_code']);

    await doc.update({
      'favorite' : _favorite[document['chapter_code']],
    }).then((onValue) {
//      print('icons updated - students history');
    });

    await FirebaseFirestore.instance
        .collection(document['teacher_uid']) // post
        .doc(document['chapter_code'])
        .get()
        .then((doc) {
          var doc1 = FirebaseFirestore.instance
              .collection(document['teacher_uid']) // post
              .doc(document['chapter_code']);

//          List<dynamic> _tmp = [];
//          Set<dynamic> _set = Set();
          var _tmp = <dynamic>[];
          var _set = <dynamic>{};

          try{
            _tmp = doc.data()!['favorite'];
            // 이미 다른 학생에게서 하트를 받은 경우.
            if(_tmp != null){
              _set = _tmp.toSet();
              _tmp = _set.toList();
              if (_favorite[document['chapter_code']]){
                _tmp.add(document['student_uid'].toString());
              } else {
                _tmp.remove(document['student_uid'].toString());
              }
              _set = _tmp.toSet();
              _tmp = _set.toList();
//              print('>>>' + _tmp.toString());
              doc1.update({
                'favorite' : _tmp,
              }).then((onValue) {
                setState(() {});
              });
            } else {
              // 처음으로 하트 받을때 처리 로직
//              print('>>> else: 에서 처리함');
              doc1.update({
                'favorite' : [document['student_uid'],],
              }).then((onValue) {
                setState(() {});
              });
            }
          } catch (error) {// 정보입력이 완료되지 않음
//            print('>>> error: ' + error.toString());
            // 처음으로 하트 받을때와 동일하게 처리
            doc1.update({
              'favorite' : [document['student_uid'],],
            }).then((onValue) {
              setState(() {});
            });
          }
    });

    //  history on the teachers question
  }

  dynamic _getImageNetwork(String url) {
    try {
      return Image.network(url, fit: BoxFit.cover);
    } catch (e) {
      return Icon(Icons.print);
    }
  }

  // ignore: missing_return
  Widget checkStudyResult(document, _answerHistory, Map _studentInfo, _userInfo)  {

    var _questions = [];
     FirebaseFirestore.instance
        .collection(document['teacher_uid'])
        .doc(document['chapter_code']) // chapter_code
        .collection('post_sub')
        .orderBy('datetime')
        .get()
        .then((QuerySnapshot querySnapshot) =>
    {
      querySnapshot.docs.forEach((doc) async {
        _questions.add(doc.data()); //모든 document 정보를 리스트에 저장.
      }),

      if(document['question_type'] == 'ex2') {
//        Navigator.push(context, MaterialPageRoute(builder: (context) {
//          return ResultEx2Page(
//              _questions, _answerHistory, _studentInfo, _userInfo);
//        }))
//         Get.to(() => ResultEx2Page(_questions, _answerHistory, _studentInfo, _userInfo));
      }
      else if(document['question_type'] == 'ex4') {
//        Navigator.push(context, MaterialPageRoute(builder: (context) {
//          return ResultEx4Page(
//              _questions, _answerHistory, _studentInfo, _userInfo);
//        }))
      }
      else if(document['question_type'] == 'matchPicture') {
//        Navigator.push(context, MaterialPageRoute(builder: (context) {
//          return ResultMatch4Page(_questions, _answerHistory, _studentInfo, 'study', _userInfo);
//        }))
      }
      else if(document['question_type'] == 'matchText') {
//        Navigator.push(context, MaterialPageRoute(builder: (context) {
//          return ResultMatchTextPage(_questions, _answerHistory, _studentInfo, 'study', _userInfo);
//        }))
      }
      else if(document['question_type'] == 'multiEx4') {
//        Navigator.push(context, MaterialPageRoute(builder: (context) {
//          return ResultMultiEx4Page(_questions, _answerHistory, _studentInfo, _userInfo);
//        }))
      }
    });
    return Container();

  }


}
