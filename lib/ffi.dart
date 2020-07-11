/// bindings for `librustystream_ffi`

import 'dart:io';
import 'package:ffi/ffi.dart' as ffi;
import 'dart:ffi';

// ignore_for_file: unused_import, camel_case_types, non_constant_identifier_names
final DynamicLibrary _dl = _open();
DynamicLibrary _open() {
  if (Platform.isWindows) return DynamicLibrary.open('build/rustystream_ffi.dll');
  if (Platform.isLinux) return DynamicLibrary.open('build/librustystream_ffi.so');
  if (Platform.isMacOS) return DynamicLibrary.open('build/librustystream_ffi.so');
  throw UnsupportedError('This platform is not supported.');
}

/// C function `store_dart_post_cobject`.
void store_dart_post_cobject(
  Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>> ptr,
) {
  _store_dart_post_cobject(ptr);
}
final _store_dart_post_cobject_Dart _store_dart_post_cobject = _dl.lookupFunction<_store_dart_post_cobject_C, _store_dart_post_cobject_Dart>('store_dart_post_cobject');
typedef _store_dart_post_cobject_C = Void Function(
  Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>> ptr,
);
typedef _store_dart_post_cobject_Dart = void Function(
  Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>> ptr,
);

/// C function `stream_subscribe`.
int stream_subscribe(
  int port,
  int n,
) {
  return _stream_subscribe(port, n);
}
final _stream_subscribe_Dart _stream_subscribe = _dl.lookupFunction<_stream_subscribe_C, _stream_subscribe_Dart>('stream_subscribe');
typedef _stream_subscribe_C = Int32 Function(
  Int64 port,
  Uint64 n,
);
typedef _stream_subscribe_Dart = int Function(
  int port,
  int n,
);

/// C function `stream_unsubscribe`.
int stream_unsubscribe() {
  return _stream_unsubscribe();
}
final _stream_unsubscribe_Dart _stream_unsubscribe = _dl.lookupFunction<_stream_unsubscribe_C, _stream_unsubscribe_Dart>('stream_unsubscribe');
typedef _stream_unsubscribe_C = Int32 Function();
typedef _stream_unsubscribe_Dart = int Function();
