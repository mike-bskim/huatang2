import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/controller/ex4_controller.dart';


class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final appBarMsg;
  final iconFlag;
  final VoidCallback? callBack;

  AppBarWidget({required this.appBarMsg, required this.iconFlag, this.callBack});

  @override
  Size get preferredSize => Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Color.fromRGBO(38, 100, 100, 1.0),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      title: Text(appBarMsg, //_multiMsg.strAppBarTitle,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: iconFlag ? Icon(Icons.file_upload, color: Colors.white,)
              : Icon(Icons.file_upload, color: Color.fromRGBO(38, 100, 100, 1.0)),
          tooltip: 'upload Image',
          onPressed: iconFlag ? callBack : null, //_uploadImage,
        )
      ],
    );
  }
}


//class QuestionTitleReadOnly extends StatelessWidget {
//  final title;
//
//  QuestionTitleReadOnly({required this.title,});
//
//  @override
//  Widget build(BuildContext context) {
//    return Text(
//      title,
//      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//    );
//  }
//}


//class QuestionImageReadOnly extends StatelessWidget {
//  final photoUrl;
//
//  QuestionImageReadOnly({required this.photoUrl});
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: photoUrl == 'NoImage' ?
//      Container(
//          width: 350,
//          height: 20,
//          child: null
//      ) :
//      Container(
//          width: 350,
//          height: 200,
//          child: Image.network(photoUrl, fit: BoxFit.cover) //, width: 1000)
//      ),
//    );
//
//  }
//}


class CheckBoxExample extends StatelessWidget {
  final Ex4Controller _ex4Controller = Get.put(Ex4Controller());
  final labelText;
  final hintText;
  final editable;
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final TextEditingController controller4;


  CheckBoxExample(
      {this.labelText, this.hintText, this.editable=true,
        required this.controller1, required this.controller2,
        required this.controller3, required this.controller4,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 45,
              child: Obx(()=>Checkbox(
                value: _ex4Controller.checkValue1.value,
                onChanged: (bool? value) => editable ? _ex4Controller.setCheckBox(1) : null,
              )),
            ),
            Flexible(
              child: TextField(
                enabled: editable,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12.0),
                    border: OutlineInputBorder(),
                    labelText: '${labelText}1)',
                    hintText: hintText),
                controller: controller1,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(4.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 45,
              child: Obx(()=>Checkbox(
                value: _ex4Controller.checkValue2.value,
                onChanged: (bool? value) => editable ? _ex4Controller.setCheckBox(2) : null,
              )),
            ),
            Flexible(
              child: TextField(
                enabled: editable,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12.0),
                    border: OutlineInputBorder(),
                    labelText: '${labelText}2)',
                    hintText: hintText),
                controller: controller2,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(4.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 45,
              child: Obx(()=>Checkbox(
                value: _ex4Controller.checkValue3.value,
                onChanged: (bool? value) => editable ? _ex4Controller.setCheckBox(3) : null,
              )),
            ),
            Flexible(
              child: TextField(
                enabled: editable,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12.0),
                    border: OutlineInputBorder(),
                    labelText: '${labelText}3)',
                    hintText: hintText),
                controller: controller3,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(4.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 45,
              child: Obx(()=>Checkbox(
                value: _ex4Controller.checkValue4.value,
                onChanged: (bool? value) => editable ? _ex4Controller.setCheckBox(4) : null,
              )),
            ),
            Flexible(
              child: TextField(
                enabled: editable,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12.0),
                    border: OutlineInputBorder(),
                    labelText: '${labelText}4)',
                    hintText: hintText),
                controller: controller4,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class RadioBoxExample extends StatelessWidget {
  final Ex4Controller _ex4Controller = Get.put(Ex4Controller());
  final labelText;
//  final hintText;
  final editable;
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final TextEditingController controller4;
//  final VoidCallback? callBack;


  RadioBoxExample(
      {this.labelText, this.editable=true,
        required this.controller1, required this.controller2,
        required this.controller3, required this.controller4,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(()=>SizedBox(
              width: 45,
              child: Radio(
                  value: StudentSelect.one,
                  groupValue: _ex4Controller.studentSelect.value,
                  onChanged: _ex4Controller.radioChanged),
            )),
            Flexible(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12.0),
                    border: OutlineInputBorder(),
                    labelText: '${labelText}1)'),
                controller: controller1,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(4.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Obx(()=>SizedBox(
              width: 45,
              child: Radio(
                  value: StudentSelect.two,
                  groupValue: _ex4Controller.studentSelect.value,
                  onChanged: _ex4Controller.radioChanged),
            )),
            Flexible(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12.0),
                    border: OutlineInputBorder(),
                    labelText: '${labelText}2)'),
                controller: controller2,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(4.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Obx(()=>SizedBox(
              width: 45,
              child: Radio(
                  value: StudentSelect.three,
                  groupValue: _ex4Controller.studentSelect.value,
                  onChanged: _ex4Controller.radioChanged),
            )),
            Flexible(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12.0),
                    border: OutlineInputBorder(),
                    labelText: '${labelText}3)'),
                controller: controller3,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(4.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Obx(()=>SizedBox(
              width: 45,
              child: Radio(
                  value: StudentSelect.four,
                  groupValue: _ex4Controller.studentSelect.value,
                  onChanged: _ex4Controller.radioChanged),
            )),
            Flexible(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12.0),
                    border: OutlineInputBorder(),
                    labelText: '${labelText}4)'),
                controller: controller4,
              ),
            ),
          ],
        ),
      ],
    );
  }

}

//     videoController = Get.find(tag: Get.parameters['videoId']);
class RadioBoxExampleReadOnly extends StatelessWidget {
//  final Ex4Controller _ex4Controller = Get.put(Ex4Controller(), tag: '_testresult');
  final Ex4Controller _ex4Controller = Get.find(tag: '_testresult');
  final labelText;
//  final hintText;
  final editable;
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final TextEditingController controller4;
  final boxColor1;
  final boxColor2;
  final boxColor3;
  final boxColor4;

//  final VoidCallback? callBack;


  RadioBoxExampleReadOnly(
      {this.labelText, this.editable=true,
        required this.controller1, required this.controller2,
        required this.controller3, required this.controller4,
        required this.boxColor1, required this.boxColor2,
        required this.boxColor3, required this.boxColor4,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 45,
              child: Radio(
                  value: StudentSelect.one,
                  groupValue: _ex4Controller.studentSelectReadOnly,
                  onChanged: null),
            ),
            Flexible(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: boxColor1,
                    contentPadding: const EdgeInsets.all(12.0),
                    border: OutlineInputBorder(),
                    labelText: '${labelText}1)'),
                controller: controller1,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(4.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          SizedBox(
              width: 45,
              child: Radio(
                  value: StudentSelect.two,
                  groupValue: _ex4Controller.studentSelectReadOnly,
                  onChanged: null),
            ),
            Flexible(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: boxColor2,
                    contentPadding: const EdgeInsets.all(12.0),
                    border: OutlineInputBorder(),
                    labelText: '${labelText}2)'),
                controller: controller2,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(4.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 45,
              child: Radio(
                  value: StudentSelect.three,
                  groupValue: _ex4Controller.studentSelectReadOnly,
                  onChanged: null),
            ),
            Flexible(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: boxColor3,
                    contentPadding: const EdgeInsets.all(12.0),
                    border: OutlineInputBorder(),
                    labelText: '${labelText}3)'),
                controller: controller3,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(4.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 45,
              child: Radio(
                  value: StudentSelect.four,
                  groupValue: _ex4Controller.studentSelectReadOnly,
                  onChanged: null),
            ),
            Flexible(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: boxColor4,
                    contentPadding: const EdgeInsets.all(12.0),
                    border: OutlineInputBorder(),
                    labelText: '${labelText}4)'),
                controller: controller4,
              ),
            ),
          ],
        ),
      ],
    );
  }

}



//class SelectExampleReadOnly extends StatelessWidget {
//  final SelectExampleController _selectExampleController = Get.put(SelectExampleController());
//  final labelText;
//  final hintText;
//  final TextEditingController controller1;
//  final TextEditingController controller2;
//  final TextEditingController controller3;
//  final TextEditingController controller4;
//  final enable;
//
//
//  SelectExampleReadOnly(
//      {this.labelText, this.hintText, this.enable=false,
//        required this.controller1, required this.controller2,
//        required this.controller3, required this.controller4,
//      });
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            SizedBox(
//              width: 45,
//              child: Checkbox(
//                value: _selectExampleController.checkValue1.value,
//                onChanged: null,
//              ),
//            ),
//            Flexible(
//              child: TextField(
//                enabled: enable,
//                decoration: InputDecoration(
//                    contentPadding: const EdgeInsets.all(12.0),
//                    border: OutlineInputBorder(),
//                    labelText: '${labelText}1)',
//                    hintText: hintText),
//                controller: controller1,
//              ),
//            ),
//          ],
//        ),
//        Padding(padding: EdgeInsets.all(4.0)),
//        Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            SizedBox(
//              width: 45,
//              child: Checkbox(
//                value: _selectExampleController.checkValue2.value,
//                onChanged: null,
//              ),
//            ),
//            Flexible(
//              child: TextField(
//                enabled: enable,
//                decoration: InputDecoration(
//                    contentPadding: const EdgeInsets.all(12.0),
//                    border: OutlineInputBorder(),
//                    labelText: '${labelText}2)',
//                    hintText: hintText),
//                controller: controller2,
//              ),
//            ),
//          ],
//        ),
//        Padding(padding: EdgeInsets.all(4.0)),
//        Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            SizedBox(
//              width: 45,
//              child: Checkbox(
//                value: _selectExampleController.checkValue3.value,
//                onChanged: null,
//              ),
//            ),
//            Flexible(
//              child: TextField(
//                enabled: enable,
//                decoration: InputDecoration(
//                    contentPadding: const EdgeInsets.all(12.0),
//                    border: OutlineInputBorder(),
//                    labelText: '${labelText}3)',
//                    hintText: hintText),
//                controller: controller3,
//              ),
//            ),
//          ],
//        ),
//        Padding(padding: EdgeInsets.all(4.0)),
//        Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            SizedBox(
//              width: 45,
//              child: Checkbox(
//                value: _selectExampleController.checkValue4.value,
//                onChanged: null,
//              ),
//            ),
//            Flexible(
//              child: TextField(
//                enabled: enable,
//                decoration: InputDecoration(
//                    contentPadding: const EdgeInsets.all(12.0),
//                    border: OutlineInputBorder(),
//                    labelText: '${labelText}4)',
//                    hintText: hintText),
//                controller: controller4,
//              ),
//            ),
//          ],
//        ),
//      ],
//    );
//  }
//}


