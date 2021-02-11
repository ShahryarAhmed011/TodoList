import 'dart:async';

import 'package:flutter/foundation.dart';

class StreamHelper {
  StreamController<double> controller;
  Stream stream;
  StreamSubscription streamSubscription;

  StreamHelper._privateConstructor() {
    controller = StreamController<double>();
    stream = controller.stream;
    //streamSubscription = stream.;
  }

  static final StreamHelper _instance = StreamHelper._privateConstructor();

  factory StreamHelper() {
    return _instance;
  }

  StreamController<double> getStreamController() {
    return controller;
  }

  void getStreamListener(ValueSetter<double> streamListen) {
    streamSubscription = stream.listen((value) {
      streamListen.call(value);
    });
  }

  void closeStreamController() {
    streamSubscription.cancel();
    controller.close();
    //controller.close();
  }
}
