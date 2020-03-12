# local_storage_example

Demonstrates how to use the local_storage package.

## Usage

```dart
import 'package:flutter/material.dart';

import 'package:local_storage/local_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Storage Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _sharedPrefController = TextEditingController();

  LocalStorageInterface _localStorage;
  String _prefStatus = '';

  void _initLocalStorage() async {
    _localStorage = await LocalStorage.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _initLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Storage Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
              child: TextField(
                controller: _sharedPrefController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type something to store...',
                ),
              ),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () async {
                final result = await _localStorage.setString(
                    'value', _sharedPrefController.text);
                setState(() => _prefStatus = result
                    ? 'Successfuly added to the Shared Prefs'
                    : 'Error occured while adding to the Shared Prefs');
              },
              child: Text('Add to shared prefs'),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                final result = _localStorage.getString('value');
                setState(() =>
                    _prefStatus = 'Retreived value from Shared Prefs: $result');
              },
              child: Text('Get from shared prefs'),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                _localStorage.clear();
                setState(() => _prefStatus = 'Cleared Shared Prefs');
              },
              child: Text('Clear shared prefs'),
            ),
          ),
          Center(child: Text(_prefStatus)),
        ],
      ),
    );
  }
}
```

## Getting Started

For help getting started with Flutter, view 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
