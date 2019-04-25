import "package:flutter/material.dart";

class MyDrawer extends StatefulWidget {
  int index;

  MyDrawer(this.index);

  /*
  0: profile
  1: vykazy
  2: messenger
  3: manager
  4: about
   */

  @override
  State<StatefulWidget> createState() {
    return _MA();
  }
}

class _MA extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("OSOBNÍ ASISTENTKA.CZ"),
          ),
          ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "Můj profil",
                style: TextStyle(
                    color: widget.index == 0
                        ? Theme.of(context).primaryColor
                        : Colors.black),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/profile");
              }),
          ListTile(
              leading: Icon(
                Icons.work,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "Výkazy práce",
                style: TextStyle(
                    color: widget.index == 1
                        ? Theme.of(context).primaryColor
                        : Colors.black),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/vykazy");
              }),
          ListTile(
              leading: Icon(
                Icons.sms,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "Messenger",
                style: TextStyle(
                    color: widget.index == 2
                        ? Theme.of(context).primaryColor
                        : Colors.black),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/chat");
              }),
          ListTile(
              leading: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "Manažerka",
                style: TextStyle(
                    color: widget.index == 3
                        ? Theme.of(context).primaryColor
                        : Colors.black),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/manager");
              }),
          ListTile(
              leading: Icon(
                Icons.info,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "O aplikaci",
                style: TextStyle(
                    color: widget.index == 4
                        ? Theme.of(context).primaryColor
                        : Colors.black),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/about");
              })
        ],
      ),
    );
  }
}
