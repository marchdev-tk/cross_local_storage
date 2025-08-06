// Copyright (c) 2025, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Wraps NSUserDefaults (on iOS and macOS), SharedPreferences (on Android),
/// LocalStorage (on Web) and native preference file (on Windows and Linux),
/// providing a persistent store for simple data.
///
/// Data is persisted to disk asynchronously.
abstract class LocalStorageInterface {
  /// Returns all keys in the persistent storage.
  Set<String> getKeys();

  /// Reads a value of any type from persistent storage.
  dynamic get(String key);

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// bool.
  bool? getBool(String key);

  /// Reads a value from persistent storage, throwing an exception if it's not
  /// an int.
  int? getInt(String key);

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// double.
  double? getDouble(String key);

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// String.
  String? getString(String key);

  /// Reads a set of string values from persistent storage, throwing an
  /// exception if it's not a string set.
  List<String>? getStringList(String key);

  /// Saves a boolean [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  Future<bool> setBool(String key, bool value);

  /// Saves an integer [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  Future<bool> setInt(String key, int value);

  /// Saves a double [value] to persistent storage in the background.
  ///
  /// Android doesn't support storing doubles, so it will be stored as a float.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  Future<bool> setDouble(String key, double value);

  /// Saves a string [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  Future<bool> setString(String key, String value);

  /// Saves a list of strings [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  Future<bool> setStringList(String key, List<String> value);

  /// Removes an entry from persistent storage.
  Future<bool> remove(String key);

  /// Completes with true once the user preferences for the app has been cleared.
  Future<bool> clear();

  /// Returns true if persistent storage the contains the given [key].
  bool containsKey(String key);

  /// Fetches the latest values from the host platform.
  ///
  /// Use this method to observe modifications that were made in native code
  /// (without using the plugin) while the app is running.
  Future<void> reload();
}
