import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusbarzTheme {
  /// The `SystemUiOverlayStyle` to apply when the background behind status bar is light. This shall
  /// use dark icons etc. Defaults to:
  /// ```dart
  /// const SystemUiOverlayStyle(
  ///    systemNavigationBarColor: Colors.white,
  ///    systemNavigationBarIconBrightness: Brightness.dark,
  ///    statusBarColor: Colors.transparent,
  ///    statusBarBrightness: Brightness.light,
  ///    statusBarIconBrightness: Brightness.dark,
  ///  )
  /// ```
  final SystemUiOverlayStyle darkStatusBar;

  /// The `SystemUiOverlayStyle` to apply when the background behind status bar is dark. This shall
  /// use light icons etc. Defaults to:
  /// ```dart
  /// const SystemUiOverlayStyle(
  ///    systemNavigationBarColor: Colors.black,
  ///    systemNavigationBarIconBrightness: Brightness.light,
  ///    statusBarColor: Colors.transparent,
  ///    statusBarBrightness: Brightness.dark,
  ///    statusBarIconBrightness: Brightness.light,
  ///  )
  /// ```
  final SystemUiOverlayStyle lightStatusBar;

  StatusbarzTheme({
    this.darkStatusBar = const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
    this.lightStatusBar = const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  });
}
