import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

class AppState extends ChangeNotifier {
  AppState() {
    init();
  }

  bool? _login;
  bool? get login => _login;

  User? _user;
  User? get user => _user;

  bool? _newAccount;
  bool? get newAccount => _newAccount;

  Future<void> init() async {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      _user = user;
      _login = user != null;

      if (user != null) {
        final userDoc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();
        _newAccount = !userDoc.exists;
      } else {
        _newAccount = false;
      }
      notifyListeners();
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
