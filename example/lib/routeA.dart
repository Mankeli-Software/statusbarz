import 'package:example/routeB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            Navigator.push(context, MaterialPageRoute(builder: (context) => RouteB()));
          },
        ),
      ),
    );
  }
}
