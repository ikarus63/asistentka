import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  MyAppBar(this.title);

  @override
  State<StatefulWidget> createState() {
    return _MA();
  }

  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _MA extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.sms),
          onPressed: () {
            String url = "sms:+420725334366";
            _launchURL(url);
          },
        ),
        IconButton(
          icon: Icon(Icons.call),
          onPressed: () {
            _callAssistant();
          },
        )
      ],
    );
  }

  _callAssistant() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString('phone');
    String url = "tel:" + phone;
    _launchURL(url);
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
