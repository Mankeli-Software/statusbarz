import 'package:flutter/material.dart';
import 'package:statusbarz/instance.dart';

/// This shall be put above MaterialApp
/// ```dart
/// void main() {
///   runApp(
///     StatusbarzObserver(
///       child: MaterialApp(
///         navigatorObservers: [Statusbarz.instance.routeObserver],
///         home: Container(),
///       ),
///     ),
///   );
/// }
/// ```
class StatusbarzObserver extends StatefulWidget {
  final Widget child;

  /// Set this to [false] in order to disable automatic status bar color changes when new route is pushed/popped.
  final bool autoRefresh;
  const StatusbarzObserver({
    Key? key,
    required this.child,
    this.autoRefresh = true,
  }) : super(key: key);

  @override
  _StatusbarzObserverState createState() => _StatusbarzObserverState();
}

class _StatusbarzObserverState extends State<StatusbarzObserver> with RouteAware {
  final _statusbarz = Statusbarz.instance;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _statusbarz.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    _statusbarz.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    if (widget.autoRefresh) {
      _statusbarz.refresh();
    }
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    if (widget.autoRefresh) {
      _statusbarz.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _statusbarz.key,
      child: widget.child,
    );
  }
}




//TODO: add example
//TODO: add readme
//TODO: buy me a coffee