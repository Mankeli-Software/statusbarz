import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:statusbarz/src/observer.dart';
import 'package:statusbarz/src/errors.dart';
import 'package:statusbarz/src/styles.dart';

import 'package:image/image.dart' as img;

class Statusbarz {
  static final GlobalKey _key = GlobalKey();
  static final Statusbarz _instance = Statusbarz._constructor();
  static final StatusbarzObserver _observer = StatusbarzObserver();

  Duration _defaultDelay = const Duration(milliseconds: 10);

  Statusbarz._constructor();

  /// Returns the interface that can be used to manually refresh the status bar color
  static Statusbarz get instance => _instance;

  /// Navigator observer to place inside MaterialApp:
  /// ```dart
  /// void main() {
  ///   runApp(
  ///     StatusbarzCapturer(
  ///       child: MaterialApp(
  ///         navigatorObservers: [Statusbarz.instance.observer],
  ///         home: Container(),
  ///       ),
  ///     ),
  ///   );
  /// }
  /// ```
  StatusbarzObserver get observer => _observer;

  set setDefaultDelay(Duration delay) => _defaultDelay = delay;

  /// Returns the key that shall be placed ONLY in StatusbarzObserver
  GlobalKey get key => _key;

  /// Changes status bar color based on the current background
  ///
  /// ### Important
  /// This operation is computationally expensive to calculate, so therefore must be used with caution.
  /// ### Error handling
  /// Throws an [StatusbarzException] if no StatusbarzCapturer found from widget tree.
  ///
  /// [Statusbarz.instance.observer] shall be placed inside [MaterialApp] in order to change status bar color automatically when new page is pushed/popped:
  /// ```dart
  /// void main() {
  ///   runApp(
  ///     StatusbarzCapturer(
  ///       child: MaterialApp(
  ///         navigatorObservers: [Statusbarz.instance.observer],
  ///         home: Container(),
  ///       ),
  ///     ),
  ///   );
  /// }
  /// ```
  ///
  /// See also:
  ///
  ///  * [StatusbarzCapturer], the widget used to find the currently rendered object
  ///  * [StatusbarzObserver], the observer used to listen to route changes
  Future<void> refresh({
    Duration? delay,
  }) async {
    return Future.delayed(
      delay ?? _defaultDelay,
      () async {
        final context = _key.currentContext;
        if (context == null) {
          throw (StatusbarzException(
              'No StatusbarzObserver found from widget tree. StatusbarzObserver shall be added above MaterialApp in your widget tree.'));
        }

        /// Finds currently rendered UI
        RenderRepaintBoundary? boundary = context.findRenderObject() as RenderRepaintBoundary?;

        /// Converts rendered UI to png
        var capturedImage = await boundary!.toImage(
          pixelRatio: 1.0,
        );
        var byteData = await capturedImage.toByteData(format: ImageByteFormat.png);
        final bytes = byteData!.buffer.asUint8List();

        var bitmap = img.decodeImage(bytes);

        var red = 0;
        var green = 0;
        var blue = 0;
        var pixels = 0;
        final window = WidgetsBinding.instance?.window;
        final mediaQuery = MediaQueryData.fromWindow(window!);
        final statusHeight = mediaQuery.padding.top.clamp(20.0, 150.0);

        /// Calculates the average color for the status bar
        for (var y = 0; y < statusHeight.toInt(); y++) {
          for (var x = 0; x < bitmap!.width; x++) {
            var c = bitmap.getPixel(x, y);

            pixels++;
            red += img.getRed(c);
            green += img.getGreen(c);
            blue += img.getBlue(c);
          }
        }

        var averageColor = Color.fromRGBO(red ~/ pixels, green ~/ pixels, blue ~/ pixels, 1);

        /// Computes the luminance. Note: This is computationally expensive.
        var luminance = averageColor.computeLuminance();

        /// Updates status bar color
        if (luminance > 0.5) {
          setDarkStatusBar();
        } else {
          setLightStatusBar();
        }
      },
    );
  }

  void setDarkStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(getDarkStatusBar());
  }

  void setLightStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(getLightStatusBar());
  }
}
