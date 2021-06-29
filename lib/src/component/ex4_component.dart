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


class QuestionTitle extends StatelessWidget {
  final titleHint;
  final TextEditingController? controller;
  final editable;

  QuestionTitle({required this.titleHint, required this.controller, this.editable = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: editable,
      decoration: InputDecoration(hintText: titleHint),
      controller: controller,
    );
  }
}

class QuestionTitleReadOnly extends StatelessWidget {
  final title;

  QuestionTitleReadOnly({required this.title,});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class QuestionImage extends StatelessWidget {
  final image;
  final msg;

  QuestionImage({required this.image, this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      child: image == null
          ? Center(child: Text(msg))
          : Image.file(
        image!,
        fit: BoxFit.cover,
      ),
    );
  }
}

class QuestionImageReadOnly extends StatelessWidget {
  final photoUrl;

  QuestionImageReadOnly({required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: photoUrl == 'NoImage' ?
      Container(
          width: 350,
          height: 20,
          child: null
      ) :
      Container(
          width: 350,
          height: 200,
          child: Image.network(photoUrl, fit: BoxFit.cover) //, width: 1000)
      ),
    );

  }
}


class SelectExample extends StatelessWidget {
  final SelectExampleController _selectExampleController = Get.put(SelectExampleController());
  final labelText;
  final hintText;
  final editable;
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final TextEditingController controller4;


  SelectExample(
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
                value: _selectExampleController.checkValue1.value,
                onChanged: (bool? value) => editable ? _selectExampleController.setCheckBox(1) : null,
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
                value: _selectExampleController.checkValue2.value,
                onChanged: (bool? value) => editable ? _selectExampleController.setCheckBox(2) : null,
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
                value: _selectExampleController.checkValue3.value,
                onChanged: (bool? value) => editable ? _selectExampleController.setCheckBox(3) : null,
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
                value: _selectExampleController.checkValue4.value,
                onChanged: (bool? value) => editable ? _selectExampleController.setCheckBox(4) : null,
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


