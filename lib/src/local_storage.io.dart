// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:async' show FutureOr;

import 'core/local_storage.interface.dart';
import 'core/local_storage.other.dart' as other;
import 'core/local_storage.common.dart' as common;

/// Wraps NSUserDefaults (on iOS and macOS), SharedPreferences (on Android),
/// LocalStorage (on Web) and JSON file (on Windows and Linux), providing a
/// persistent store for simple data.
///
/// Data is persisted to disk asynchronously.
class LocalStorage {
  const LocalStorage._();

  static FutureOr<LocalStorageInterface> getInstance() async {
    if (Platform.isWindows || Platform.isLinux) {
      return await other.LocalStorageStore.getInstance();
    }

    return await common.LocalStorageStore.getInstance();
  }
}
