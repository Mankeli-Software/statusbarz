import 'package:flutter/material.dart';
import 'package:statusbarz/instance.dart';

class StatusBarzObserver extends StatefulWidget {
  final Widget child;
  const StatusBarzObserver({Key? key, required this.child}) : super(key: key);

  @override
  _StatusBarzObserverState createState() => _StatusBarzObserverState();
}

class _StatusBarzObserverState extends State<StatusBarzObserver> {
  final _statusbarz = Statusbarz.instance;
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _statusbarz.key,
      child: widget.child,
    );
  }
}
