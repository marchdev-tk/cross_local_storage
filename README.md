# cross_local_storage

![Build](https://github.com/marchdev-tk/cross_local_storage/workflows/build/badge.svg)
[![Pub](https://img.shields.io/pub/v/cross_local_storage.svg)](https://pub.dartlang.org/packages/cross_local_storage)
![GitHub](https://img.shields.io/github/license/marchdev-tk/cross_local_storage)
![GitHub stars](https://img.shields.io/github/stars/marchdev-tk/cross_local_storage?style=social)

Wraps NSUserDefaults (on iOS and macOS), SharedPreferences (on Android), LocalStorage (on Web) and JSON file (on Windows and Linux), providing a persistent store for simple data.
Data is persisted to disk asynchronously.
Neither platform can guarantee that writes will be persisted to disk after returning and this plugin must not be used for storing critical data.

## Getting Started

In order to use this plugin, add dependency in the `pubspec.yaml`:

```yaml
cross_local_storage: any
```

or

```yaml
cross_local_storage:
  git:
    url: https://github.com/marchdev-tk/cross_local_storage
```

Add an import to dart file:

```dart
import 'package:cross_local_storage/cross_local_storage.dart';
```

### Example

```dart
import 'package:flutter/material.dart';
import 'package:cross_local_storage/cross_local_storage.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
      child: RaisedButton(
        onPressed: _incrementCounter,
        child: Text('Increment Counter'),
        ),
      ),
    ),
  ));
}

_incrementCounter() async {
  LocalStorageInterface prefs = await LocalStorage.getInstance();
  int counter = (prefs.getInt('counter') ?? 0) + 1;
  print('Pressed $counter times.');
  await prefs.setInt('counter', counter);
```

## Feature requests and Bug reports

Feel free to post a feature requests or report a bug [here](https://github.com/marchdev-tk/cross_local_storage/issues).
