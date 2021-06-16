# Dynamic status bar plugin

## Features

A Flutter package for dynamically changing status bar color based on the background. Can be set up to automatically change the color whenever the current route is changed. It is also possible to manually refresh the color.

## Usage

Place `StatusbarzCapturer` above your `MaterialApp` widget:

```dart
void main() {
  runApp(
    StatusbarzCapturer(
      child: MaterialApp(
        home: Container(),
      ),
    ),
  );
}
```

Now you can manually refresh status bar color by calling:

```dart
Statusbarz.instance.refresh();
```

Or alternatively you can refresh automatically when the current route changes. To do this, simply add `Statusbarz.instance.observer` to your `MaterialApp`s `navigatorObservers`:

```dart
void main() {
  runApp(
    StatusbarzCapturer(
      child: MaterialApp(
        navigatorObservers: [Statusbarz.instance.observer],
        home: Container(),
      ),
    ),
  );
}
```
