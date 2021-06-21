import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
                    print('-----------------------------');
                    print('Google: ' + user.toString());
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
                    print('-----------------------------');
                    print('Facebook: ' + user.toString());
                  });
                },
              ),
//              ElevatedButton(
//                child: Text('Logout'),
//                  onPressed: () {
//                    _auth.signOut();
//                    _googleSignIn.signOut();
//                    _facebookSignIn.logOut();
//                  },
//              ),
              Padding(
                padding: EdgeInsets.all(30.0),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future _handleSignIn() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

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
    final LoginResult result = await _facebookSignIn.login();

    // Create a credential from the access token
    final facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);

    // Once signed in, return the UserCredential
//    return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    final authResult = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    final user = authResult.user;

    return user;
  }

}
