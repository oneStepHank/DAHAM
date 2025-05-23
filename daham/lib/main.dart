import 'package:daham/Appstate/appsate.dart';
import 'package:daham/Pages/Login/login.dart';
import 'package:daham/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) return Daham();
        // Loading
        return const MaterialApp(
          home: Scaffold(body: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}

class Daham extends StatelessWidget {
  const Daham({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: Consumer<AppState>(
        builder: (context, state, _) {
          return MaterialApp(
            initialRoute: state.login ? '/' : '/sign',
            routes: {
              '/sign': (context) => Login(),
              '/': (context) => Center(child: Text('Hello World!')),
            },
          );
        },
      ),
    );
  }
}
