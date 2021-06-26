import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/model/multi_msg.dart';
import 'package:huatang2/src/pages/create_sub_ex4_page.dart';

import 'list_ex4_page.dart';

class DetailStudyPage extends StatefulWidget {
  final dynamic chapterInfo;

  DetailStudyPage(this.chapterInfo); //, this.userInfo

  @override
  _DetailStudyPageState createState() => _DetailStudyPageState();
}

class _DetailStudyPageState extends State<DetailStudyPage> {
  final UserInfoController _userInfoController = Get.put(UserInfoController());

  final _textController1 = TextEditingController();
  final _testResult = [];
  int _testResultCntStudent = 0;
  final _boxFit = BoxFit.cover;
  var qTotal = 0;
  final _multiMsg = MultiMessageDetail();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTestResult();
    _getSubQuestionCnt();
  }

  @override
  Widget build(BuildContext context) {
    _multiMsg.convertDescription(_userInfoController.userInfo['userLangType']);
    _textController1.text = widget.chapterInfo['description1'];

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(38, 100, 100, 1.0),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            _multiMsg.strAppBarTitle,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            PopupMenuButton<int>(
              icon: Icon(Icons.sort),
              onSelected: (value) {
                if (value == 0) {
                  _addQuestion();
                } else if (value == 1) {
                  _showQuestion();
                } else {
                  deleteChapter();
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 0,
                    enabled: _testResultCntStudent > 0 ? false : true,
                    child: Text(_multiMsg.strAddSub),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Text(_multiMsg.strListSub),
                  ),
                  PopupMenuItem(
                    value: 2,
                    enabled: _testResultCntStudent > 0 ? false : true,
                    child: Text(_multiMsg.strDelete),
                  )
                ];
              },
            )
          ]),
      body: _buildBody(),
    );
  }

  Future _addQuestion() async {
    var _resultAdd = false;
    var _msg;

    print('_addQuestion: ${widget.chapterInfo['question_type'].toString()}');

    if (_testResultCntStudent > 0) {
      _msg = _multiMsg.strWarnAdd;
      var _dialogResult = await warningDialog(context, _multiMsg.strWarnMessage, _msg);
      if (_dialogResult.toString() == 'true') {
        //call setState here to rebuild your state.
      }
    } else {
      if (widget.chapterInfo['question_type'] == 'ex2') {
//        _resultAdd = await Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) =>
//              CreateSubEx2Page(widget.document, widget.userInfo)),
//        );
      } else if (widget.chapterInfo['question_type'] == 'ex4') {
        // ex4
//        _resultAdd = await Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) =>
//              CreateSubEx4Page(widget.document, widget.userInfo)),
//        );
        _resultAdd = await Get.to(() => CreateSubEx4Page(widget.chapterInfo)); //widget.user
      } else if (widget.chapterInfo['question_type'] == 'matchPicture') {
//        _resultAdd = await Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) =>
//              CreateSubMatch4Page(widget.document, widget.userInfo)),
//        );
      } else if (widget.chapterInfo['question_type'] == 'matchText') {
//        _resultAdd = await Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) =>
//              CreateSubMatchTextPage(widget.document, widget.userInfo)),
//        );
      } else if (widget.chapterInfo['question_type'] == 'multiEx4') {
//        _resultAdd = await Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) =>
//              CreateSubMultiEx4Page(widget.document, widget.userInfo)),
//        );
      }
      if (_resultAdd) {
        _getSubQuestionCnt();
      }
    }
  }

  Future _showQuestion() async {
    var _resultShow;

    if (widget.chapterInfo['question_type'] == 'ex2') {
//      _resultShow = await Navigator.push(
//        context,
//        MaterialPageRoute(
//          builder: (context) =>
//            ListEx2Page(widget.document['teacher_uid'], widget.document['id'],
//              this._testResultCntStudent, widget.userInfo)),
//      );
    } else if (widget.chapterInfo['question_type'] == 'ex4') {
//      _resultShow = await Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) =>
//                ListEx4Page(widget.chapterInfo['teacher_uid'], widget.chapterInfo['id'],
//                    _testResultCntStudent)),// , widget.userInfo
//      );
      _resultShow = await Get.to(() => ListEx4Page(
          widget.chapterInfo['teacher_uid'], widget.chapterInfo['id'], _testResultCntStudent));
    } else if (widget.chapterInfo['question_type'] == 'matchPicture') {
//      _resultShow = await Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) =>
//                ListMatch4Page(widget.document['teacher_uid'], widget.document['id'],
//                    this._testResultCntStudent, widget.userInfo)),
//      );
    } else if (widget.chapterInfo['question_type'] == 'matchText') {
//      _resultShow = await Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) =>
//                ListMatchTextPage(widget.document['teacher_uid'], widget.document['id'],
//                    this._testResultCntStudent, widget.userInfo)),
//      );
    } else if (widget.chapterInfo['question_type'] == 'multiEx4') {
//      _resultShow = await Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) =>
//                ListMultiEx4Page(widget.document['teacher_uid'], widget.document['id'],
//                    this._testResultCntStudent, widget.userInfo)),
//      );
    }

    if (_resultShow) {
      _getSubQuestionCnt();
    }
  }

  Widget _buildBody() {
    var _questionType = 'N/A';
    if (widget.chapterInfo['question_type'] == 'ex4') {
      _questionType = _multiMsg.strEx4;
    } else if (widget.chapterInfo['question_type'] == 'ex2') {
      _questionType = _multiMsg.strTF;
    } else if (widget.chapterInfo['question_type'] == 'matchPicture') {
      _questionType = _multiMsg.strMatchPicture;
    } else if (widget.chapterInfo['question_type'] == 'matchText') {
      _questionType = _multiMsg.strMatchText;
    } else if (widget.chapterInfo['question_type'] == 'multiEx4') {
      _questionType = _multiMsg.strMultiEx4;
    }

    return WillPopScope(
      onWillPop: () async {
        await _updateSubQuestionCnt();
//        Navigator.of(context).pop(true);
        Get.back(result: true);
        return Future.value(true);
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(8.0)),
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: Container(
                child: Text(
                  widget.chapterInfo['contents'],
                  style: TextStyle(fontSize: 30),
                ),
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
            Hero(
              tag: widget.chapterInfo['photoUrl'],
              child: Container(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                width: 350,
                height: 240,
                child: Stack(children: <Widget>[
                  Container(
                      width: 350,
                      height: 240,
                      child: Material(
                        child: InkWell(
                            onTap: () {
                              _showQuestion();
                            },
                            child: Image.network(
                              widget.chapterInfo['photoUrl'],
                              fit: _boxFit,
                            )),
                      )),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 120.0,
                      height: 20.0,
                      alignment: Alignment.center,
                      color: Colors.black54,
                      child: Text(
                        '${_multiMsg.strQCnt}: ' + qTotal.toString(),
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              '${_multiMsg.strQType}: ' + _questionType,
              style: TextStyle(fontSize: 18),
            ),
            Padding(padding: EdgeInsets.all(4.0)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  var _textCopy =
                      "${_multiMsg.strTeacherUid}: ${widget.chapterInfo['teacher_uid']}";
                  _textCopy += "\n";
                  _textCopy += "${_multiMsg.strTestCode}: ${widget.chapterInfo['id']}";
                  Clipboard.setData(ClipboardData(text: _textCopy));
                },
                child: Text(_multiMsg.strCopy)),
            Padding(padding: EdgeInsets.all(8.0)),
            Container(
              padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      enabled: false,
                      maxLines: 3,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(12.0),
                        border: OutlineInputBorder(),
                      ),
                      //hintText: 'Please input the description', labelText: 'Description',
                      controller: _textController1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getSubQuestionCnt() {
    FirebaseFirestore.instance
        .collection(widget.chapterInfo['teacher_uid'])
        .doc(widget.chapterInfo['id'])
        .collection('post_sub')
        .get()
        .then((snapShot) {
      setState(() {
        qTotal = snapShot.docs.length;
      });
    });
  }

  // ignore: always_declare_return_types
  deleteData(docId) {
    FirebaseFirestore.instance
        .collection(widget.chapterInfo['teacher_uid'])
        .doc(docId)
        .collection('post_sub')
        .get()
        .then((snapshot) async {
      for (DocumentSnapshot ds in snapshot.docs) {
        await ds.reference.delete();
        if (ds['question_type'] == 'matchPicture') {
          final ref1 = FirebaseStorage.instance.refFromURL(ds['photoUrl_1']);
          await ref1.delete(); //delete sub questions' pictures
          final ref2 = FirebaseStorage.instance.refFromURL(ds['photoUrl_2']);
          await ref2.delete(); //delete sub questions' pictures
          final ref3 = FirebaseStorage.instance.refFromURL(ds['photoUrl_3']);
          await ref3.delete(); //delete sub questions' pictures
          final ref4 = FirebaseStorage.instance.refFromURL(ds['photoUrl_4']);
          await ref4.delete(); //delete sub questions' pictures
        } else if (ds['question_type'] == 'matchText') {
          print('There is no Image(matchText)');
        } else {
          if (ds['photoUrl'] == 'NoImage') {
            print('There is no Image');
          } else {
            final ref = FirebaseStorage.instance.refFromURL(ds['photoUrl']);
            await ref.delete(); //delete sub questions' pictures
          }
        }
      }
    });

    FirebaseFirestore.instance
        .collection(widget.chapterInfo['teacher_uid'])
        .doc(docId)
        .collection('student')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });

    FirebaseFirestore.instance
        .collection(widget.chapterInfo['teacher_uid'])
        .doc(docId)
        .delete()
        .catchError((e) {
      print(e);
    }).then((onValue) async {
      final ref = FirebaseStorage.instance.refFromURL(widget.chapterInfo['photoUrl']);
      await ref.delete(); //delete main chapter's pictures
//      Navigator.pop(context);
      Get.back();
    });
  }

  // ignore: always_declare_return_types
  deleteChapter() async {
    //handleClear, deleteChapter
    var _msg;
    if (_testResultCntStudent > 0) {
      _msg = _multiMsg.strWarnAdd;
      var _dialogResult = await warningDialog(context, _multiMsg.strWarnMessage, _msg);
      if (_dialogResult.toString() == 'true') {
        //call setState here to rebuild your state.
      }
    } else {
      try {
        var delete = await deleteLoanWarning(
          context,
          _multiMsg.strWarnMessage,
          _multiMsg.strWarnDelete,
        );
        if (delete.toString() == 'true') {
          //call setState here to rebuild your state.
          await deleteData(widget.chapterInfo['id']); // IbJB3jwVBR7WRsPXqAG9
        }
      } catch (error) {
        print('error clearing notifications' + error.toString());
      }
    }
  }

  Future<bool> deleteLoanWarning(BuildContext context, String title, String msg) async {
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
          ),
          context: context,
        ) ??
        false;
  }

  //widget.document['teacher_uid'], widget.document['id']
  Future _loadTestResult() async {
    _testResult.clear();

//    var result = await FirebaseFirestore.instance
    await FirebaseFirestore.instance
        .collection(widget.chapterInfo['teacher_uid']) //
        .doc(widget.chapterInfo['id']) // chapter_code
        .collection('student')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                _testResult.add(doc.data());
              })
            });

//    if (result.toString() != null) {
    _testResultCntStudent = 0;
    for (var i = 0; i < _testResult.length; i++) {
      if (_testResult[i]['user_type'] == 'Student') {
        _testResultCntStudent += 1;
      }
    }
//    }
  }

  Future<bool> warningDialog(BuildContext context, String title, String msg) async {
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
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    _multiMsg.strOk,
                  ),
                ),
              ),
            ],
          ),
          context: context,
        ) ??
        false;
  }

//    .collection(widget.document['teacher_uid']) //
//    .doc(widget.document['id']) // chapter_code
//    .collection('student')
  Future<void> _updateSubQuestionCnt() async {
    var _questionCount = 0;

//    var result = await FirebaseFirestore.instance
    await FirebaseFirestore.instance
        .collection(widget.chapterInfo['teacher_uid'])
        .doc(widget.chapterInfo['id']) // chapter_code
        .collection('post_sub')
        .get()
        .then((QuerySnapshot querySnapshot1) => {
              _questionCount = (querySnapshot1.docs.length),
            });
//    if(result.toString() != null) {
    var doc = FirebaseFirestore.instance
        .collection(widget.chapterInfo['teacher_uid']) // teacher uid
        .doc(widget.chapterInfo['id']); // chapter_code

    await doc.update({
      'question_cnt': _questionCount,
    });
//    }
  }
}
