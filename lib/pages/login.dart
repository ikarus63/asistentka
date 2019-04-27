import "package:flutter/material.dart";
import './profile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {

  final String URL = "http://212.24.148.132/Test_Asistentka/MobileApp/";

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String input;
  String email;
  String initialID;
  String sessionID;
  bool progress = false;

  @override
  Widget build(BuildContext context) {
    if (progress) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (email == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Text("Osobní asistenka.cz"),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  "PŘIHLÁŠENÍ",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Váš email"),
                onChanged: (String s) {
                  input = s;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                child: Text("Autorizovat"),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    email = input;
                    progress = true;
                    sendSMS();
                  });
                },
              ),
              Image.asset("assets/logo.png"),
            ],
          ),
        ),
      );
    } else if (sessionID == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Text("Osobní asistenka.cz"),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  "SMS KÓD",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Ověřovací SMS kód (nechte prázdné)"),
                onChanged: (String s) {
                  input = s;
                },
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                child: Text("Ověřit"),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    initialID = "de9659f5-832b-40ed-8f3f-cb12fc38487d";
                    progress = true;
                    getSessionID();
                  });
                },
              ),
              Image.asset("assets/logo.png"),
            ],
          ),
        ),
      );
    } else {
      return ProfilePage();
    }
  }

  sendSMS() async {
    http.Response response = await http.get(
        widget.URL + "NewSession?mailAddress=" +
            email);

    setState(() {
      progress = false;
    });
  }

  getSessionID() async {
    http.Response response = await http.get(
        widget.URL + "ValidateSession?initialCode=" +
            initialID);

    Map<String, dynamic> r = jsonDecode(response.body);

    sessionID = r["ROOT"];

    saveSessionID();
  }

  saveSessionID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sessionID', sessionID);
    setState(() {
      progress = false;
    });
  }
}
