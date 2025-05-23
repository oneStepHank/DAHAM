import 'package:flutter/widgets.dart';

import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

class AppState extends ChangeNotifier {
  AppState() {
    init();
  }

  bool _login = false;
  bool get login => _login;

  Future<void> init() async {}
}
