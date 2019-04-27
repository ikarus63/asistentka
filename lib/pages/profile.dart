import "package:flutter/material.dart";
import '../appbar.dart';
import '../drawer.dart';
import 'dart:convert';
import '../models/contact.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {

  final String URL = "http://212.24.148.132/Test_Asistentka/MobileApp/";

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  var name;
  var balance;
  var minutePrice;
  var validity;
  var monthRate;
  List<Contact> contacts = new List<Contact>();

  @override
  Widget build(BuildContext context) {
    if (name == null) {
      getData();
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        drawer: MyDrawer(0),
        appBar: MyAppBar("Můj profil"),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Moje údaje",
                      style: TextStyle(
                          fontSize: 26.0,
                          color: Theme.of(context).primaryColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "Klient: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      name.toString(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "Platnost smlouvy: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      validity.toString(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "Měsíční paušál: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      monthRate.toString(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "Minutová sazba: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      minutePrice.toString() + " Kč",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "Stav konta: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      balance.toString(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Kontaktní údaje",
                      style: TextStyle(
                          fontSize: 26.0,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                  ]..addAll(getContacts()),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  getContacts() {
    var data;
    data = <Widget>[Container()];

    for (int i = 0; i < contacts.length; i++) {
      Contact c = contacts[i];

      data = data
        ..addAll(<Widget>[
          SizedBox(
            height: 6.0,
          ),
          Text(
            c.name.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            c.value.toString(),
            textAlign: TextAlign.center,
          ),
        ]);
    }

    data = data
      ..addAll(<Widget>[
        SizedBox(
          height: 10.0,
        ),
      ]);

    return data;
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sessionID = prefs.getString('sessionID');

    if (sessionID == null || sessionID == "") {
      exit(0);
    }

    http.Response response = await http.get(
        widget.URL + "Dashboard/" +
            sessionID);

    Map<String, dynamic> d = jsonDecode(response.body);

    Map<String, dynamic> data = jsonDecode(response.body);

    data = d["ROOT"]["BusinessPartner"][0];
    name = data["FullName"];
    minutePrice = data["Project"][0]["OA_PricePerMinute"];
    balance = data["OA_AccountBalance"];
    validity = data["Project"][0]["OA_ValidFrom"].toString() +
        " - " +
        data["Project"][0]["OA_ValidUntil"].toString();

    monthRate = data["Project"][0]["OA_MonthlyRate"];

    List<dynamic> contacts = data["BusinessPartnerCommunicationChannel"];

    contacts.forEach((e) {
      Map<String, dynamic> a = e;
      String n = a["BusinessPartnerCommunicationChannelType_Name"];
      String v = a["Text"];

      if(n.toLowerCase().trim() == "interni telefon"){
        prefs.setString("phone", v);
      }

      Contact c = new Contact(name: n, value: v);
      this.contacts.add(c);
    });

    setState(() {});
  }
}
