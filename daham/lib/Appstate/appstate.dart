import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AppState extends ChangeNotifier {
  AppState() {
    init();
  }

  bool _login = false;
  bool get login => _login;

  User? _user;
  User? get user => _user;

  Future<void> init() async {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      _login = user != null;
      notifyListeners();
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
