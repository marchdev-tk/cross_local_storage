// Copyright (c) 2025, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:cross_local_storage/cross_local_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Storage Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _sharedPrefController = TextEditingController();

  late LocalStorageInterface _localStorage;
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
        title: const Text('Local Storage Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: TextField(
                controller: _sharedPrefController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type something to store...',
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final result = await _localStorage.setString(
                    'value', _sharedPrefController.text);
                setState(() => _prefStatus = result
                    ? 'Successfuly added to the Shared Prefs'
                    : 'Error occured while adding to the Shared Prefs');
              },
              child: const Text('Add to shared prefs'),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () {
                final result = _localStorage.getString('value');
                setState(() =>
                    _prefStatus = 'Retreived value from Shared Prefs: $result');
              },
              child: const Text('Get from shared prefs'),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _localStorage.clear();
                setState(() => _prefStatus = 'Cleared Shared Prefs');
              },
              child: const Text('Clear shared prefs'),
            ),
          ),
          const SizedBox(height: 12),
          Center(child: Text(_prefStatus)),
        ],
      ),
    );
  }
}
