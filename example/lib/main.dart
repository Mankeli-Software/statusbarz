import 'package:example/routeA.dart';
import 'package:flutter/material.dart';
import 'package:statusbarz/statusbarz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatusbarzCapturer(
      child: MaterialApp(
        navigatorObservers: [Statusbarz.instance.observer],
        title: 'Statusbarz example',
        home: RouteA(),
      ),
    );
  }
}
