import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle getLightStatusBar() => const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    );

SystemUiOverlayStyle getDarkStatusBar() => const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    );
