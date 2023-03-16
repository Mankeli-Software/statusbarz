[![style: mankeli analysis][1]][2]

[![pub package][3]][4]

[![License][5]][6]
![[CI]][7]

[!["Buy Me A Coffee"][8]][9]
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


[1]: https://img.shields.io/badge/style-mankeli__analysis-blue
[2]: https://pub.dev/packages/mankeli_analysis
[3]: https://img.shields.io/pub/v/statusbarz.svg
[4]: https://pub.dev/packages/statusbarz
[5]: https://img.shields.io/badge/license-BSD%203--clause-blue.svg
[6]: https://opensource.org/licenses/BSD-3-Clause
[7]: https://github.com/Mankeli-Software/statusbarz/actions/workflows/ci.yaml/badge.svg
[8]: https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png
[9]: https://www.buymeacoffee.com/mankeli