import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

typedef ErrorHandler = void Function(String message);

class Phonecallstate {
  Phonecallstate() {
    _channel.setMethodCallHandler(platformCallHandler);
  }

  static const MethodChannel _channel =
      MethodChannel('com.plusdt.phonecallstate');

  VoidCallback incomingHandler;
  VoidCallback dialingHandler;
  VoidCallback connectedHandler;
  VoidCallback disconnectedHandler;
  ErrorHandler errorHandler;

  Future<dynamic> setTestMode(double seconds) =>
      _channel.invokeMethod<dynamic>('phoneTest.PhoneIncoming', seconds);

  void setIncomingHandler(VoidCallback callback) {
    incomingHandler = callback;
  }

  void setDialingHandler(VoidCallback callback) {
    dialingHandler = callback;
  }

  void setConnectedHandler(VoidCallback callback) {
    connectedHandler = callback;
  }

  void setDisconnectedHandler(VoidCallback callback) {
    disconnectedHandler = callback;
  }

  void setErrorHandler(ErrorHandler handler) {
    errorHandler = handler;
  }

  Future<void> platformCallHandler(MethodCall call) async {
    print('_platformCallHandler call ${call.method} ${call.arguments}');
    switch (call.method) {
      case 'phone.incoming':
        //print("incoming");
        if (incomingHandler != null) {
          incomingHandler();
        }
        break;
      case 'phone.dialing':
        //print("dialing");
        if (dialingHandler != null) {
          dialingHandler();
        }
        break;
      case 'phone.connected':
        //print("connected");
        if (connectedHandler != null) {
          connectedHandler();
        }
        break;
      case 'phone.disconnected':
        //print("disconnected");
        if (disconnectedHandler != null) {
          disconnectedHandler();
        }
        break;
      case 'phone.onError':
        if (errorHandler != null) {
          errorHandler(call.arguments);
        }
        break;
      default:
        print('Unknowm method ${call.method} ');
    }
  }
}
