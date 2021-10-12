
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medico/login.dart';
import 'package:medico/main.dart';
import 'package:medico/utils/auth.dart';

void main()
{
  runApp(RootPage(auth: Auth()));
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness:
      Brightness.light, //or set color with: Color(0xFF0000FF)
    ));
    super.initState();
    authStatus = AuthStatus.NOT_LOGGED_IN;
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user){
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
      print('loggerr');

    });
  }

  void _onSignedOut() {
    setState(() {
      widget.auth.signOut();
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget _buildWaitingScreen() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new Login(
          widget.auth,
          _onLoggedIn,
        );
        break;
      case AuthStatus.LOGGED_IN:
        /*if (_userId.length > 0 && _userId != null) {
          return MyApp(
            _userId,
            widget.auth,
            _onSignedOut,
          );
        } else return _buildWaitingScreen();*/
        return MyApp(
          _userId,
          widget.auth,
          _onSignedOut,
        );
        break;
      default:
        return _buildWaitingScreen();
    }
  }
}


