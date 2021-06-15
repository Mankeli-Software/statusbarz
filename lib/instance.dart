import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:statusbarz/errors.dart';

import 'package:statusbarz/styles.dart';
import 'package:image/image.dart' as img;

class Statusbarz {
  static final GlobalKey _key = GlobalKey();
  static final Statusbarz _instance = Statusbarz._constructor();
  static final RouteObserver<ModalRoute<void>> _routeObserver = RouteObserver<ModalRoute<void>>();

  Statusbarz._constructor();

  /// Returns the interface that can be used to manually refresh the status bar color
  static Statusbarz get instance => _instance;

  /// Returns the key that shall be placed ONLY in StatusbarzObserver
  GlobalKey get key => _key;

  /// routeObserver shall be placed inside materialApp in order to change status bar color automatically when new page is pushed:
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
  RouteObserver<ModalRoute<void>> get routeObserver => _routeObserver;

  /// Changes status bar color based on the current background
  ///
  /// ### Important
  /// This operation is computationally expensive to calculate, so therefore must be used with caution.
  /// ### Error handling
  /// Throws an [StatusbarzException] if no StatusbarzObserver found from widget tree.
  /// See also:
  ///
  ///  * [StatusbarzObserver], the widget used to find the currently rendered object
  Future<void> refresh() async {
    return Future.delayed(
      const Duration(milliseconds: 10),
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

        /// Gets the height of the status bar for the current device
        final statusHeight = MediaQuery.of(context).viewPadding.top.toInt();

        /// Calculates the average color for the status bar
        for (var y = 0; y < statusHeight; y++) {
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
          SystemChrome.setSystemUIOverlayStyle(getDarkStatusBar());
        } else {
          SystemChrome.setSystemUIOverlayStyle(getLightStatusBar());
        }
      },
    );
  }
}
