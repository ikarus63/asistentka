import "package:flutter/material.dart";
import '../appbar.dart';
import '../drawer.dart';
import '../knihovny/buble.dart';

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MA();
  }
}

class _MA extends State<ChatPage> {
  String email;

  Widget _messagesWidget() {
    return ListView(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Bubble(
              message: "Ahoj",
              time: "22:29",
              delivered: false,
              isMe: true,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Bubble(
              message: "Ahoj",
              time: "22:29",
              delivered: false,
              isMe: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextComposer() {
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        //new
        children: <Widget>[
          //new
          new Flexible(
            //new
            child: new TextField(
              decoration:
                  new InputDecoration.collapsed(hintText: "Send a message"),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {},
          ) //new
        ], //new
      ), //new
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(2),
      appBar: MyAppBar("Messenger"),
      body: Column(
        //modified
        children: <Widget>[
          //new
          new Flexible(
              //new
              child: _messagesWidget() //new
              ), //new
          new Divider(height: 1.0), //new
          new Container(
            //new
            decoration:
                new BoxDecoration(color: Theme.of(context).cardColor), //new
            child: _buildTextComposer(), //modified
          ), //new
        ], //new
      ), //new
    );
  }
}
