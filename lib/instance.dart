import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:statusbarz/styles.dart';
import 'package:image/image.dart' as img;

class Statusbarz {
  static final GlobalKey _key = GlobalKey();
  static final Statusbarz _instance = Statusbarz._constructor();

  Statusbarz._constructor();

  static Statusbarz get instance => _instance;

  GlobalKey get key => _key;

  Future<void> refresh(BuildContext context) async {
    return Future.delayed(const Duration(milliseconds: 10), () async {
      RenderRepaintBoundary? boundary = _key.currentContext!.findRenderObject() as RenderRepaintBoundary?;
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

      final statusHeight = MediaQuery.of(context).viewPadding.top.toInt();

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

      var luminance = averageColor.computeLuminance();

      if (luminance > 0.5) {
        SystemChrome.setSystemUIOverlayStyle(getDarkStatusBar());
      } else {
        SystemChrome.setSystemUIOverlayStyle(getLightStatusBar());
      }
    });
  }
}
