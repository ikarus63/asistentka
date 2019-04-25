import "package:flutter/material.dart";
import '../appbar.dart';
import '../drawer.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AboutPageState();
  }
}

class _AboutPageState extends State<AboutPage> {
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(4),
        appBar: MyAppBar("O aplikaci"),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Card(
                  child: Column(
                children: <Widget>[
                Image.asset("assets/logo.png"),
                  Text(
                    "Asistentka CZ, s.r.o.",
                    style: TextStyle(
                        fontSize: 26.0, color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    "IČ: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("24166570"),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    "DIČ: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("CZ24166570"),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    "Datová schránka: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("qub63wt"),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    "Sídlo: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Poděbradská 88/55, budova C"),
                  Text("198 00 Praha 9 – Hloubětín"),
                  SizedBox(
                    height: 6.0,
                  ),
                ],
              )),
              Card(
                child: Column(children: <Widget>[
                  Text(
                    "Kontakt",
                    style: TextStyle(
                        fontSize: 26.0, color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    "Telefon: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("+420 226 259 311 "),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    "E-mail: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("info@osobniasistentka.cz"),
                  SizedBox(
                    height: 6.0,
                  ),
                ]),
              ),
              Card(
                  child: Column(children: <Widget>[
                Text(
                  "Vývojář aplikace",
                  style: TextStyle(
                      fontSize: 26.0, color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Společnost:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Palla Software, s.r.o."),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  "IČ:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("07627106"),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  "Telefon: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("+420 499 599 225"),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  "E-mail: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("info@pallasoftware.cz"),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  "Web: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("www.PallaSoftware.cz"),
                SizedBox(
                  height: 6.0,
                )
              ])),
            ],
          ),
        ));
  }
}
