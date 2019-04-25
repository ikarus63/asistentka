import 'package:flutter/material.dart';
import "./pages/login.dart";
import 'package:shared_preferences/shared_preferences.dart';
import './pages/profile.dart';
import './pages/about.dart';
import './pages/manager.dart';
import './pages/vykazy.dart';

void main() => runApp(new Application());

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Osobní asistenka',
      theme: new ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepPurple,
          brightness: Brightness.light),
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the FirstScreen Widget
        '/': (context) => MyApp(),
        // When we navigate to the "/second" route, build the SecondScreen Widget
        '/profile': (context) => ProfilePage(),
        '/about': (context) => AboutPage(),
        '/manager': (context) => ManagerPage(),
        '/vykazy': (context) => VykazyPage(),
      },
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool loaded = false;
  bool existSessionID = false;

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      loadData();
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (existSessionID) {
        return ProfilePage();
      } else {
        return LoginPage();
      }
    }
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sessionID = prefs.getString('sessionID');

    if (sessionID == null || sessionID == "") {
      existSessionID = false;
    } else {
      existSessionID = true;
    }

    loaded = true;

    setState(() {});
  }
}
