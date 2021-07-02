import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Ex2Controller extends GetxController {
  static Ex2Controller get to => Get.find();

  bool? teacherAnswer;
  RxObjectMixin buttonColor1 = Colors.blueAccent.obs;
  RxObjectMixin buttonColor2 = Colors.blueAccent.obs;
//  Color buttonColor1 = Colors.blueAccent;
//  Color buttonColor2 = Colors.blueAccent;


//  Rx<StudentSelect> studentSelect = (StudentSelect.zero).obs;
//  StudentSelect? studentSelectReadOnly;
//  Map answerHistory = {};
//  int currentPage = 0;

@override
  void onInit() {
    // TODO: implement onInit
    // 매 번경시마다 동작, 리엑티브 상태일때만 가능.
//    ever(_chapterInfo, (_) => print(_chapterInfo.length));
    super.onInit();
  }


}

