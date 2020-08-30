import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool darkThemeEnabled = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.darkThemeEnabled,
      initialData: false,
      builder: (context, snapshot) => MaterialApp(
          theme: snapshot.data ? ThemeData.dark() : ThemeData.light(),
          home: HomePage(snapshot.data)),
    );
  }
}

class HomePage extends StatelessWidget {
  bool darkThemeEnabled;
  HomePage(this.darkThemeEnabled);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text("Dynamic Theming"),
        ),
        body: Center(child: Text("Hello World")),
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            ListTile(
              title: new Text("Dark Theme"),
              trailing:
                  Switch(value: darkThemeEnabled, onChanged: bloc.changeTheme),
            )
          ],
        )));
  }
}

class Bloc {
  final _themeController = StreamController<bool>();
  get changeTheme => _themeController.sink.add;
  get darkThemeEnabled => _themeController.stream;
}

final bloc = Bloc();
