import 'package:flutter/material.dart';

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
