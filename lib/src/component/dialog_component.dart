import 'package:flutter/material.dart';

class WarningYesNo extends StatelessWidget {
  final title;
  final msg;
  final YesMsg;
  final NoMsg;
  WarningYesNo({required this.title, required this.msg, required this.YesMsg, required this.NoMsg});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
            child: Text(NoMsg),
          ),
        ),
        Container(
          decoration: BoxDecoration(),
          child: MaterialButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(YesMsg),
          ),
        ),
      ],
    );
  }




  Future<bool> deleteLoanWarning(
      BuildContext context, String title, String msg) async {
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
              child: Text('No'
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(),
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'
              ),
            ),
          ),
        ],
      ), context: context,
    ) ??
        false;
  }
}
