import 'package:flutter/widgets.dart';
import 'package:statusbarz/statusbarz.dart';

/// A custom navigator observer to refresh status bar color when route changes
class StatusbarzObserver extends NavigatorObserver {
  final _instance = Statusbarz.instance;
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _handleRouteRemoved(route);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _handleRouteAdded(route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _handleRouteRemoved(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _handleRouteAdded(newRoute);
  }

  void _handleRouteRemoved(Route<dynamic>? route) {
    if (route is ModalRoute) {
      final status = route.animation!.status;

      if (status != AnimationStatus.dismissed) {
        /// Assures there are not duplicate listeners
        route.animation!.removeStatusListener(_routeRemovedListener);
        route.animation!.addStatusListener(_routeRemovedListener);

        return;
      }
    }

    _instance.refresh();
  }

  void _handleRouteAdded(Route<dynamic>? route) {
    if (route is ModalRoute) {
      final status = route.animation!.status;

      if (status != AnimationStatus.completed) {
        /// Assures there are not duplicate listeners
        route.animation!.removeStatusListener(_routeAddedListener);
        route.animation!.addStatusListener(_routeAddedListener);

        return;
      }
    }

    _instance.refresh();
  }

  void _routeRemovedListener(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      _instance.refresh();
    }
  }

  void _routeAddedListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _instance.refresh();
    }
  }
}
