import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

//    final AccessToken result = await FacebookAuth.instance.login();
class LoginPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookAuth _facebookSignIn = FacebookAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Easy',
                    style: TextStyle(
                        fontSize: 40,
//                      color: Colors.redAccent,
                        color: Color.fromRGBO(38, 100, 100, 1.0),
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Container(
                    child: Icon(Icons.star, size: 50, color: Colors.orangeAccent,),
                  ),
                  Text('Funny',
                    style: TextStyle(
                        fontSize: 40,
//                      color: Colors.redAccent,
                        color: Color.fromRGBO(38, 100, 100, 1.0),
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(10.0),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Play',
                    style: TextStyle(
                        fontSize: 20, color: Colors.black38, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: Icon(Icons.local_library, size: 25, color: Colors.black87,),
                  ),
                  Text('Study',
                    style: TextStyle(
                        fontSize: 20, color: Colors.black38, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(40.0),),
              SignInButton(
                Buttons.Google,
                onPressed: () {
                  _handleSignIn().then((user) {
                    print('Google: login');
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              SignInButton(
                Buttons.Facebook,
                onPressed: () {
                  signInWithFacebook().then((user) {
                    print('Facebook: login');
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              SignInButton(
                Buttons.AppleDark,
                onPressed: () {
                  print('------- apple ID is not ready');
//                  signInWithApple().then((user) {
//                    print('Apple: login');
//                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              SignInButton(
                Buttons.Email,
                onPressed: () async {
                  print('------- Email authorization');
                  final result = await Get.to(() => Email()); //widget.user
                  print('result: ' + result.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _handleSignIn() async {
//    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final authResult = await _auth.signInWithCredential(credential);
    final user = authResult.user;

    return user;
  }


  // <UserCredential>
  Future signInWithFacebook() async {
    // Trigger the sign-in flow
//    final AccessToken result = await FacebookAuth.instance.login();
//    final LoginResult result = await _facebookSignIn.login();
    final result = await _facebookSignIn.login();

    // Create a credential from the access token
    final facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);

    // Once signed in, return the UserCredential
//    return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    final authResult = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    final user = authResult.user;

    return user;
  }

  // <UserCredential>, ios 13 이상인 경우
  Future signInWithApple() async {

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
//    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    final authResult = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    final user = authResult.user;

    return user;
  }

}


class Email extends StatelessWidget {

  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(38, 100, 100, 1.0),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text('Sign in with Email',
          style: TextStyle(color: Colors.white)//, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email', //_multiMsg.strTeacherUid,
                ),
                controller: _textController1,
              ),
            ),
            Padding(padding: EdgeInsets.all(16.0)),
            Flexible(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password', //_multiMsg.strTestCode
                ),
                controller: _textController2,
              ),
            ),
            Padding(padding: EdgeInsets.all(16.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {
                    },
                    label: Text("Log in"),
                    icon: Icon(Icons.login),
                  ),
                ),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {
                    },
                    label: Text("Sign up"),
                    icon: Icon(Icons.edit),
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}
