// Copyright (c) 2025, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async' show FutureOr;

import 'core/local_storage.interface.dart';
import 'core/local_storage.json.dart';

/// Wraps IO of a JSON file, providing a persistent store for simple data,
/// just like usual SharePreferences.
///
/// Data is persisted to disk asynchronously.
class LocalStorage {
  const LocalStorage._();

  static FutureOr<LocalStorageInterface?> getInstance() =>
      LocalStorageStore.getInstance();
}
