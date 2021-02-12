import 'dart:async';

import 'package:flutter/foundation.dart';

class StreamHelper {
  StreamController<dynamic> controller;
  Stream stream;
  StreamSubscription streamSubscription;

  StreamHelper._privateConstructor() {
    controller = StreamController<dynamic>();
    stream = controller.stream;
    //streamSubscription = stream.;
  }

  static final StreamHelper _instance = StreamHelper._privateConstructor();

  factory StreamHelper() {
    return _instance;
  }

  StreamController<dynamic> getStreamController() {
    return controller;
  }

  void getStreamListener(ValueSetter<dynamic> streamListen) {
    streamSubscription = stream.listen((value) {
      streamListen.call(value);
    });
  }

  void closeStreams() {
    streamSubscription.cancel();
    controller.close();
  }
}
