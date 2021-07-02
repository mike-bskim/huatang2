import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/controller/ex2_controller.dart';

class TrueFalseBox extends StatelessWidget {
  final Ex2Controller _ex2Controller = Get.put(Ex2Controller());
  final trueMsg;
  final falseMsg;

  TrueFalseBox({this.trueMsg, this.falseMsg});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      SizedBox(
        width: 150,
        height: 150,
        child: Obx(() => ElevatedButton(
              //RaisedButton
              style: ElevatedButton.styleFrom(
                primary: _ex2Controller.buttonColor1.value,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                _ex2Controller.teacherAnswer = true;
//                _ex2Controller.buttonColor1.value = Colors.blue;
//                _ex2Controller.buttonColor2.value = Colors.lime;
                print(_ex2Controller.teacherAnswer);
              }, //RaisedButton
              child: Text(trueMsg, style: TextStyle(fontSize: 30)),
            )),
      ),
      Padding(padding: EdgeInsets.all(10.0)),
      SizedBox(
        width: 150,
        height: 150,
        child: Obx(() => ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: _ex2Controller.buttonColor2.value,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                _ex2Controller.teacherAnswer = false;
//                _ex2Controller.buttonColor1.value = Colors.lime;
//                _ex2Controller.buttonColor2.value = Colors.blue;
                print(_ex2Controller.teacherAnswer);
              },
              child: Text(falseMsg, style: TextStyle(fontSize: 30)),
            )),
      ),
    ]);
  }
}

class TrueFalseBoxSetState extends StatefulWidget {
  final trueMsg;
  final falseMsg;
  final editable;
  final trueColor;
  final falseColor;

  TrueFalseBoxSetState(
      {this.trueMsg,
      this.falseMsg,
      this.editable = true,
      this.trueColor,
      this.falseColor});

  @override
  _TrueFalseBoxSetStateState createState() => _TrueFalseBoxSetStateState();
}

class _TrueFalseBoxSetStateState extends State<TrueFalseBoxSetState> {
  final Ex2Controller _ex2Controller = Get.put(Ex2Controller());
  Color _buttonColor1 = Colors.blueAccent;
  Color _buttonColor2 = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      SizedBox(
        width: 150,
        height: 150,
        child: ElevatedButton(
          //RaisedButton
          style: ElevatedButton.styleFrom(
            primary: widget.editable ? _buttonColor1 : widget.trueColor,
            onPrimary: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _ex2Controller.teacherAnswer = true;
              _buttonColor1 = Colors.lightGreen;
              _buttonColor2 = const Color(0xFFd2d2d2);
              print(_ex2Controller.teacherAnswer);
            });
          }, //RaisedButton
          child: Text(widget.trueMsg, style: TextStyle(fontSize: 30)),
        ),
      ),
      Padding(padding: EdgeInsets.all(10.0)),
      SizedBox(
        width: 150,
        height: 150,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: widget.editable ? _buttonColor2 : widget.falseColor,
            onPrimary: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _ex2Controller.teacherAnswer = false;
              _buttonColor1 = const Color(0xFFd2d2d2);
              _buttonColor2 = Colors.lightGreen;
              print(_ex2Controller.teacherAnswer);
            });
          },
          child: Text(widget.falseMsg, style: TextStyle(fontSize: 30)),
        ),
      ),
    ]);
  }
}
