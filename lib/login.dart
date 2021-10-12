import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medico/utils/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}
class Login extends StatelessWidget {
  BaseAuth _auth;
  VoidCallback onSignedIn;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anaadyanta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Montserrat"
      ),
      home: MyHomePage(
          title: 'Anaadyanta', auth: _auth, onSignedIn: onSignedIn),
    );
  }

  Login(this._auth, this.onSignedIn);

}


class MyHomePage extends StatefulWidget {
  VoidCallback onSignedIn;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _authy = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _authy.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    ).then((user){
      onSignedIn();});
    print("signed in " + user.displayName);
    return user;
  }
  MyHomePage({Key key, this.title, this.auth, this.onSignedIn})
      : super(key: key) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness:
      Brightness.light, //or set color with: Color(0xFF0000FF)
    ));
  }

  BaseAuth auth;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Offset _car;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery
        .of(context)
        .padding;

    return Scaffold(
      backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
      body: Container(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      // Box decoration takes a gradient
                      gradient: LinearGradient(
                        // Where the linear gradient begins and ends
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        // Add one stop for each color. Stops should increase from 0 to 1
                        stops: [0.0, 1.0],
                        colors: [
                          Color.fromRGBO(162,153,201, 1.0),
                          Color.fromRGBO(88,28,180, 1.0),
                        ],
                      ),
                    ),
                  )),
              Positioned.fill(
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: devicePadding.top + 50.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 100,),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Form(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 20.0),
                                        child: Text('Login With Your Google Account'),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                25.0),
                                            gradient: LinearGradient(
                                              colors: <Color>[
                                                Color.fromRGBO(
                                                    189,52,96, 1.0),
                                                Color.fromRGBO(
                                                    149,0,0, 1.0)
                                              ],
                                            )),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                              onTap: () {
                                                widget._handleSignIn();
                                              },
                                              child: Center(
                                                child: Text("Sign In",
                                                    style: TextStyle(
                                                        fontFamily: "Montserrat",
                                                        fontSize: 16,
                                                        color: Colors.white)),
                                              )),
                                        ),
                                      )
                                    ],
                                  )),
                            )),
                        ])),
              ),
            ],
          )),
    );
  }
}
