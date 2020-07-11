import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:isolate';

import 'ffi.dart';

class Events {
  Events({this.n = 100})
      : _responsePort = RawReceivePort(),
        _streamController = StreamController() {
    store_dart_post_cobject(NativeApi.postCObject);
    _responsePort.handler = _streamController.add;
    stream_subscribe(_responsePort.sendPort.nativePort, n);
  }

  final int n;
  final RawReceivePort _responsePort;
  final StreamController<String> _streamController;
  Stream<dynamic> get stream => _streamController.stream.map(Event.fromJson);

  void dispose() {
    stream_unsubscribe();
    _streamController.close();
    _responsePort.close();
  }
}

class Event {
  static dynamic fromJson(String json) {
    if (json == null) {
      return null;
    }
    // ignore: avoid_as
    final payload = jsonDecode(json) as Map<String, dynamic>;
    if (payload['Ping'] != null) {
      return PingEvent.fromJson(payload);
    } else if (payload['Update'] != null) {
      return UpdateEvent.fromJson(payload);
    } else if (payload['UpdateProgress'] != null) {
      return UpdateProgressEvent.fromJson(payload);
    } else {
      return null;
    }
  }
}

class PingEvent {
  PingEvent({this.ping});

  PingEvent.fromJson(Map<String, dynamic> json) {
    if (json['Ping'] != null) {
      ping = [];
    }
  }
  List<void> ping;

  @override
  String toString() {
    return 'Ping {}';
  }
}

class UpdateEvent {
  UpdateEvent({this.update});

  UpdateEvent.fromJson(Map<String, dynamic> json) {
    // ignore: avoid_as
    update = json['Update'] as String;
  }

  String update;

  @override
  String toString() {
    return 'Update($update)';
  }
}

class UpdateProgressEvent {
  UpdateProgressEvent({this.updateProgress});

  UpdateProgressEvent.fromJson(Map<String, dynamic> json) {
    // ignore: avoid_as
    updateProgress = json['UpdateProgress'] as int;
  }

  int updateProgress;

  @override
  String toString() {
    return 'UpdateProgress($updateProgress)';
  }
}
