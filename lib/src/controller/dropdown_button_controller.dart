import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownButtonController extends GetxController {
  RxString langTypeIndex = 'English'.obs;
  RxString userTypeIndex = 'Student'.obs;
  var langType = ['한글', 'English', '中文'];
  RxList userType = ['Teacher', 'Student'].obs;
//  var selectedUserType;
  var selectedUserTypeForDB;
//  var selectedLangType;
  var selectedLangTypeForDB;

  void changeLangTypeIndex(String index) {
    langTypeIndex(index);
    print('change LangType: ${index.toString()}');

    if(langTypeIndex.value == '한글') {
      userType = ['선생님', '학생'].obs;
      changeUserTypeIndex('학생');
      selectedLangTypeForDB = 'Korean';
    }
    else if(langTypeIndex.value == 'English') {
      userType = ['Teacher', 'Student'].obs;
      changeUserTypeIndex('Student');
      selectedLangTypeForDB = 'English';
    }
    else if(langTypeIndex.value == '中文') {
      userType = ['老师', '学生'].obs;
      changeUserTypeIndex('学生');
      selectedLangTypeForDB = 'Chinese';
    }
    else {
      selectedLangTypeForDB = 'Other';
    }
    print('userType: ${userType.toString()}');
  }

  void changeUserTypeIndex(String index) {
    userTypeIndex(index);
    print('change UserType: ${index.toString()}');
  }

  void changeLTypeIndex(String index) {
    userTypeIndex(index);
    print('change UserType: ${index.toString()}');
  }

  void changeUserType(List msg) {
    userType(msg);
  }

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
