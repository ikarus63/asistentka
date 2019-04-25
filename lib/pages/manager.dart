import "package:flutter/material.dart";
import '../appbar.dart';
import '../drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class ManagerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManagerPageState();
  }
}

class _ManagerPageState extends State<ManagerPage> {
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(3),
      appBar: MyAppBar("Manažerka asistentky"),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Kontaktovat manažerku",
                    style: TextStyle(
                        fontSize: 26.0, color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                        "Pokud máte nějaké problémy, otázky či připomínky, neváhejte mě kontaktovat (stačí kliknout na jednu z možností níže):"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            GestureDetector(
              onTap: () {
                String url = "tel:+420776471  399";
                _launchURL(url);
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Telefon:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "+420 776 471 399",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                String url = "mailto:kristyna.kucharova@osobniasistentka.cz";
                _launchURL(url);
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Email:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "kristyna.kucharova@osobniasistentka.cz",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
