// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async' show FutureOr;

import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage.interface.dart';

/// Wraps NSUserDefaults (on iOS and macOS), SharedPreferences (on Android),
/// LocalStorage (on Web) and JSON file (on Windows and Linux), providing a
/// persistent store for simple data.
///
/// Data is persisted to disk asynchronously.
class LocalStorageStore implements LocalStorageInterface {
  LocalStorageStore._(this._pref);

  final SharedPreferences _pref;

  static LocalStorageInterface _instance;
  static FutureOr<LocalStorageInterface> getInstance() async {
    return _instance ??=
        LocalStorageStore._(await SharedPreferences.getInstance());
  }

  /// Returns all keys in the persistent storage.
  @override
  Set<String> getKeys() => _pref.getKeys();

  /// Reads a value of any type from persistent storage.
  @override
  dynamic get(String key) => _pref.get(key);

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// bool.
  @override
  bool getBool(String key) => _pref.getBool(key);

  /// Reads a value from persistent storage, throwing an exception if it's not
  /// an int.
  @override
  int getInt(String key) => _pref.getInt(key);

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// double.
  @override
  double getDouble(String key) => _pref.getDouble(key);

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// String.
  @override
  String getString(String key) => _pref.getString(key);

  /// Reads a set of string values from persistent storage, throwing an
  /// exception if it's not a string set.
  @override
  List<String> getStringList(String key) => _pref.getStringList(key);

  /// Saves a boolean [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  @override
  Future<bool> setBool(String key, bool value) => _pref.setBool(key, value);

  /// Saves an integer [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  @override
  Future<bool> setInt(String key, int value) => _pref.setInt(key, value);

  /// Saves a double [value] to persistent storage in the background.
  ///
  /// Android doesn't support storing doubles, so it will be stored as a float.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  @override
  Future<bool> setDouble(String key, double value) =>
      _pref.setDouble(key, value);

  /// Saves a string [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  @override
  Future<bool> setString(String key, String value) =>
      _pref.setString(key, value);

  /// Saves a list of strings [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  @override
  Future<bool> setStringList(String key, List<String> value) =>
      _pref.setStringList(key, value);

  /// Removes an entry from persistent storage.
  @override
  Future<bool> remove(String key) => _pref.remove(key);

  /// Completes with true once the user preferences for the app has been cleared.
  @override
  Future<bool> clear() => _pref.clear();

  /// Returns true if persistent storage the contains the given [key].
  @override
  bool containsKey(String key) => _pref.containsKey(key);

  /// Fetches the latest values from the host platform.
  ///
  /// Use this method to observe modifications that were made in native code
  /// (without using the plugin) while the app is running.
  @override
  Future<void> reload() => _pref.reload();
}
