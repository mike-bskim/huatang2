//import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum StudentSelect { one, two, three, four , zero}

class Ex4Controller extends GetxController {
  static Ex4Controller get to => Get.find();

  final RxBool checkValue1 = false.obs;
  final RxBool checkValue2 = false.obs;
  final RxBool checkValue3 = false.obs;
  final RxBool checkValue4 = false.obs;
  final RxInt teacherAnswer = 0.obs;
  final RxInt studentAnswer = 0.obs;
  final RxBool iconFlag = true.obs;
  RxList<dynamic> questions = [].obs;
  Map question = {};

  Rx<StudentSelect> studentSelect = (StudentSelect.zero).obs;
  late StudentSelect studentSelectReadOnly;
  Map answerHistory = {};
  int currentPage = 0;

@override
  void onInit() {
    // TODO: implement onInit
    // 매 번경시마다 동작, 리엑티브 상태일때만 가능.
//    ever(_chapterInfo, (_) => print(_chapterInfo.length));
    super.onInit();
  }

  void questionsClear(){
    questions.clear();
  }

  void mappingQuestions(List items) {
//    print('LIST: ' + items.length.toString());
    question.clear();
    questions.clear();
    if(items.isNotEmpty) {
      for (var i=0; i<items.length; i++) {
        question['title'] = items[i]['contents'];
        question['correct1'] = items[i]['correct1'];
//        questions[i] = question;
        questions.add(question);
        print('length: ${items.length.toString()}');
        print(question.toString());
        print('many: ' + questions.toString());
      }

      print(items[0]['contents']);
      print(items[1]['contents']);
    }
  }

  RxList<dynamic> get getQuestions => questions;

  void setIconFlag(bool flag) {
    iconFlag(flag);
  }

//  bool get iconFlag => iconFlag as bool;

  void setCheckBox(int index) {
    if (index == 1) {
      checkValue1(true);
      checkValue2(false);
      checkValue3(false);
      checkValue4(false);
      teacherAnswer(1);
    } else if (index == 2) {
      checkValue1(false);
      checkValue2(true);
      checkValue3(false);
      checkValue4(false);
      teacherAnswer(2);
    } else if (index == 3) {
      checkValue1(false);
      checkValue2(false);
      checkValue3(true);
      checkValue4(false);
      teacherAnswer(3);
    } else if (index == 4) {
      checkValue1(false);
      checkValue2(false);
      checkValue3(false);
      checkValue4(true);
      teacherAnswer(4);
    } else {
      checkValue1(false);
      checkValue2(false);
      checkValue3(false);
      checkValue4(false);
      teacherAnswer(0);
    }

  }

  void radioChanged(StudentSelect? value) {
    studentSelect(value);
//    print('radioChanged: $value');
      if (studentSelect.value == StudentSelect.one) {
        studentAnswer(1);
        answerHistory[currentPage] = 1;
      } else if (studentSelect.value == StudentSelect.two) {
        studentAnswer(2);
        answerHistory[currentPage] = 2;
      } else if (studentSelect.value == StudentSelect.three) {
        studentAnswer(3);
        answerHistory[currentPage] = 3;
      } else {
        studentAnswer(4);
        answerHistory[currentPage] = 4;
      }
  }

}

