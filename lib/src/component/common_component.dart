import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WarningYesNo extends StatelessWidget {
  final title;
  final msg;
  final YesMsg;
  final NoMsg;
  WarningYesNo({required this.title, required this.msg, required this.YesMsg, required this.NoMsg});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title,
//          style: new TextStyle(fontWeight: fontWeight, color: CustomColors.continueButton),
        textAlign: TextAlign.center,
      ),
      content: Text(msg,
//          textAlign: TextAlign.justify,
      ),
      actions: <Widget>[
        Container(
          decoration: BoxDecoration(),
          child: MaterialButton(
            onPressed: () {
              print('WarningYesNo >> false');
//              Navigator.of(context).pop(false);
              Get.back(result: false);
            },
            child: Text(NoMsg),
          ),
        ),
        Container(
          decoration: BoxDecoration(),
          child: MaterialButton(
            onPressed: () {
              print('WarningYesNo >> true');
//              Navigator.of(context).pop(true);
              Get.back(result: true);
            },
            child: Text(YesMsg),
          ),
        ),
      ],
    );
  }
}


class WarningNotice extends StatelessWidget {
  final title;
  final msg;
  final btnMsg;

  WarningNotice({required this.title, required this.msg, required this.btnMsg});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(msg),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            print('WarningNotice >> true');
            Get.back(result: true);
          },
          child: Text(btnMsg),
        ),
      ],
    );
  }
}


class QuestionTitle extends StatelessWidget {
  final titleHint;
  final TextEditingController? controller;
  final editable;

  QuestionTitle({this.titleHint, this.controller, this.editable = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      enabled: editable,
      decoration: InputDecoration(
        hintText: titleHint,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0)
        ),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0)
        ),
//        border: UnderlineInputBorder(
//            borderSide: BorderSide(color: Colors.black),
//        ),
      ),
      controller: controller,
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
//      decoration: BoxDecoration(
//          border: Border.all(color: Colors.black12)
//      ),
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