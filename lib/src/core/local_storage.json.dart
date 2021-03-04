// Copyright (c) 2021, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' show File;
import 'dart:convert' show json;
import 'dart:async' show FutureOr;

import 'local_storage.interface.dart';

/// Wraps IO of a JSON file, providing a persistent store for simple data,
/// just like usual SharePreferences.
///
/// Data is persisted to disk asynchronously.
class LocalStorageStore implements LocalStorageInterface {
  LocalStorageStore._(this._preferenceCache);

  /// The cache that holds all preferences.
  ///
  /// It is instantiated to the current state of the SharedPreferences or
  /// NSUserDefaults object and then kept in sync via setter methods in this
  /// class.
  ///
  /// It is NOT guaranteed that this cache and the device prefs will remain
  /// in sync since the setter method might fail for any reason.
  final Map<String, Object>? _preferenceCache;

  static const String _prefFileName = 'preferences.json';

  static LocalStorageStore? _instance;
  static FutureOr<LocalStorageStore> getInstance() async {
    if (_instance == null) {
      final preferences = await _getSharedPreferencesMap();
      _instance = LocalStorageStore._(preferences);
    }

    return _instance!;
  }

  /// Returns all keys in the persistent storage.
  @override
  Set<String> getKeys() => Set<String>.from(_preferenceCache!.keys);

  /// Reads a value of any type from persistent storage.
  @override
  dynamic get(String key) => _preferenceCache![key];

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// bool.
  @override
  bool? getBool(String key) => _preferenceCache![key] as bool?;

  /// Reads a value from persistent storage, throwing an exception if it's not
  /// an int.
  @override
  int? getInt(String key) => _preferenceCache![key] as int?;

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// double.
  @override
  double? getDouble(String key) => _preferenceCache![key] as double?;

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// String.
  @override
  String? getString(String key) => _preferenceCache![key] as String?;

  /// Reads a set of string values from persistent storage, throwing an
  /// exception if it's not a string set.
  @override
  List<String>? getStringList(String key) {
    List<Object>? list = _preferenceCache![key] as List<Object>?;
    if (list != null && list is! List<String>) {
      list = list.cast<String>().toList();
      _preferenceCache![key] = list;
    }
    // Make a copy of the list so that later mutations won't propagate
    return list?.toList() as List<String>?;
  }

  /// Saves a boolean [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  @override
  Future<bool> setBool(String key, bool value) => _setValue('Bool', key, value);

  /// Saves an integer [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  @override
  Future<bool> setInt(String key, int value) => _setValue('Int', key, value);

  /// Saves a double [value] to persistent storage in the background.
  ///
  /// Android doesn't support storing doubles, so it will be stored as a float.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  @override
  Future<bool> setDouble(String key, double value) =>
      _setValue('Double', key, value);

  /// Saves a string [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  @override
  Future<bool> setString(String key, String value) =>
      _setValue('String', key, value);

  /// Saves a list of strings [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  @override
  Future<bool> setStringList(String key, List<String> value) =>
      _setValue('StringList', key, value);

  /// Removes an entry from persistent storage.
  @override
  Future<bool>? remove(String key) => _preferenceCache!.remove(key) as Future<bool>?;

  /// Completes with true once the user preferences for the app has been cleared.
  @override
  Future<bool> clear() async {
    _preferenceCache!.clear();
    return true;
  }

  /// Returns true if persistent storage the contains the given [key].
  @override
  bool containsKey(String key) => _preferenceCache!.containsKey(key);

  /// Fetches the latest values from the host platform.
  ///
  /// Use this method to observe modifications that were made in native code
  /// (without using the plugin) while the app is running.
  @override
  Future<void> reload() async {
    final preferences = await (_getSharedPreferencesMap() as FutureOr<Map<String, Object>>);
    _preferenceCache!.clear();
    _preferenceCache!.addAll(preferences);
  }

  Future<bool> _setValue(String valueType, String key, Object value) {
    if (value == null) {
      _preferenceCache!.remove(key);
    } else {
      if (value is List<String>) {
        // Make a copy of the list so that later mutations won't propagate
        _preferenceCache![key] = value.toList();
      } else {
        _preferenceCache![key] = value;
      }
    }

    return _commit();
  }

  Future<bool> _commit() async {
    final file = File(_prefFileName);
    final jsonString = json.encode(_preferenceCache);
    await file.writeAsString(jsonString);
    return true;
  }

  static Future<Map<String, Object>?> _getSharedPreferencesMap() async {
    final file = File(_prefFileName);
    if (await file.exists()) {
      final jsonString = await file.readAsString();
      if (jsonString.isNotEmpty == true) {
        final map = json.decode(jsonString);
        return map;
      }
    } else {
      await file.create();
    }

    return {};
  }
}
