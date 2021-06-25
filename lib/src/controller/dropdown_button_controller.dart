import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownButtonController extends GetxController {
  RxString langTypeIndex = 'English'.obs;
  RxString userTypeIndex = 'Student'.obs;
  RxMap multiMsg = {
    'strAppBarTitle': 'User Information',
    'strLang': 'User Lang',
    'strUserType': 'User Type',
    'strApply': 'Apply',
  }.obs;

  var langType = ['한글', 'English', '中文'];
  RxList userType = ['Teacher', 'Student'].obs;
  var _selectedUserTypeForDB;
  var _selectedLangTypeForDB;


  void changeLangTypeIndex(String index) {
    langTypeIndex(index);

    if(langTypeIndex.value == '한글') {
      userType = ['선생님', '학생'].obs;
      multiMsg['strAppBarTitle'] = '사용자 정보 선택';
      multiMsg['strLang'] = '사용자 언어';
      multiMsg['strUserType'] = '사용자 유형';
      multiMsg['strApply'] = '적용';
      _selectedLangTypeForDB = 'Korean';
      changeUserTypeIndex('학생');
    }
    else if(langTypeIndex.value == 'English') {
      userType = ['Teacher', 'Student'].obs;
      multiMsg['strAppBarTitle'] = 'User Information';
      multiMsg['strLang'] = 'User Lang';
      multiMsg['strUserType'] = 'User Type';
      multiMsg['strApply'] = 'Apply';
      _selectedLangTypeForDB = 'English';
      changeUserTypeIndex('Student');
    }
    else if(langTypeIndex.value == '中文') {
      userType = ['老师', '学生'].obs;
      multiMsg['strAppBarTitle'] = '用户信息';
      multiMsg['strLang'] = '语言';
      multiMsg['strUserType'] = '种类';
      multiMsg['strApply'] = '应用';
      _selectedLangTypeForDB = 'Chinese';
      changeUserTypeIndex('学生');
    }
    else {
      _selectedLangTypeForDB = 'Other';
    }
  }

  void changeUserTypeIndex(String index) {
    userTypeIndex(index); //userTypeIndex.value

    if(userTypeIndex.value == '선생님' || userTypeIndex.value == 'Teacher'
        || userTypeIndex.value == '老师') {
      _selectedUserTypeForDB = 'Teacher';
    }
    else if(userTypeIndex.value == '학생' || userTypeIndex.value == 'Student'
        || userTypeIndex.value == '学生') {
      _selectedUserTypeForDB = 'Student';
    }
  }

  String get selectedUserTypeForDB => _selectedUserTypeForDB;
  String get selectedLangTypeForDB => _selectedLangTypeForDB;
}

class DropdownButtonLangType extends StatelessWidget {
  final DropdownButtonController _dropdownButtonController = Get.put(DropdownButtonController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> DropdownButton<String>(
        onChanged: (String? value) {
          _dropdownButtonController.changeLangTypeIndex(value!);
        },
        value: _dropdownButtonController.langTypeIndex.value, //_selectedUserType,
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        items: _dropdownButtonController.langType.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(dropDownStringItem),
          );
        }).toList(),
      ),
    );
  }
}

class DropdownButtonUserType extends StatelessWidget {
  final DropdownButtonController _dropdownButtonController = Get.put(DropdownButtonController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> DropdownButton<String>(
        onChanged: (String? value) {
          _dropdownButtonController.changeUserTypeIndex(value!);
        },
        value: _dropdownButtonController.userTypeIndex.value, //_selectedUserType,
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        items: [
          DropdownMenuItem(
              value: _dropdownButtonController.userType[0],
              child: Text(_dropdownButtonController.userType[0])
          ),
          DropdownMenuItem(
              value: _dropdownButtonController.userType[1],
              child: Text(_dropdownButtonController.userType[1])
          ),
        ]
      ),
    );
  }
}
