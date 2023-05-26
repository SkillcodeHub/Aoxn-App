import 'package:flutter/material.dart';

class ViewWidget extends StatefulWidget {
  @override
  ViewWidgetState createState() => ViewWidgetState();
}

class ViewWidgetState extends State {
  bool viewVisible = false;

  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          ElevatedButton(
            child: Text('Hide Widget on Button Click'),
            onPressed: hideWidget,
            // color: Colors.pink,
            // textColor: Colors.white,
            // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          ),
          Card(
            color: Colors.amber,
            child: ElevatedButton(
              child: Text('Show Widget on Button Click'),
              onPressed: showWidget,
              // color: Colors.pink,
              // textColor: Colors.white,
              // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            ),
          ),
          Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: viewVisible,
              child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.green,
                  margin: EdgeInsets.only(top: 50, bottom: 30),
                  child: Center(
                      child: Text('Show Hide Text View Widget in Flutter',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 23))))),
        ],
      ),
    );
  }
}
