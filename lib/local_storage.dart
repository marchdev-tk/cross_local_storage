// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library local_storage;

export 'src/core/local_storage.interface.dart';
export 'src/local_storage.stub.dart'
    if (dart.library.html) 'src/local_storage.web.dart'
    if (dart.library.io) 'src/local_storage.io.dart';
