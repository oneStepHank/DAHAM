// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daham/Provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class AppState extends ChangeNotifier {
  AppState();

  bool? _login;
  bool? get login => _login;

  User? _user;
  User? get user => _user;

  bool? _newAccount;
  bool? get newAccount => _newAccount;

  Future<void> init(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      _user = user;
      _login = user != null;

      final userState = Provider.of<UserState>(context, listen: false);

      if (user != null) {
        userState.listenUserDoc(user.uid);
        final userDoc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();
        _newAccount = !userDoc.exists;
      } else {
        userState.clear();
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
