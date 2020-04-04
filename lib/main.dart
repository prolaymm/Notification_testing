import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

void main() => runApp(new MaterialApp(home: new MyHomePage()));

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: selectNotification);
  }

  //To show Dialog in Application When the Notification Clicked
  Future selectNotification(String payload) {
    debugPrint('print payload : $payload');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Local Notification'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Click Button to To Test Notification',
            ),
            new RaisedButton(
                elevation: 5,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                splashColor: Colors.white70,
                child: Text(
                  'Click me',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: workingWithNotification)
          ],
        ),
      ),
    );
  }

//To show the notification when 'Click me' button is clicked
  workingWithNotification() async {
    var android = new AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();

    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'This is Title', 'This is Subtitle', platform,
        payload: 'You clicked the Notification');
  }
}
