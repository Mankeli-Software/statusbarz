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

class RouteA extends StatelessWidget {
  const RouteA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: ElevatedButton(
          child: Text('Change screen to B'),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => RouteB()));
          },
        ),
      ),
    );
  }
}

class RouteB extends StatelessWidget {
  const RouteB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: ElevatedButton(
          child: Text('Change screen to A'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
