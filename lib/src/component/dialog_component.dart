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
//              Navigator.of(context).pop(true);
              Get.back(result: false);
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
            Get.back(result: true);
          },
          child: Text(btnMsg),
        ),
      ],
    );
  }
}