import 'package:daham/Appstate/appstate.dart';
import 'package:daham/Pages/Login/login.dart';
import 'package:daham/Pages/test/home_page.dart';
import 'package:daham/Provider/group_provider.dart';
import 'package:daham/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => GroupProvider()),
      ],
      child: const RootApp(),
    ),
  );
}

// 처음 앱 시작 시 Firebase 초기화 후 Daham 앱을 실행
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
    return Consumer<AppState>(
      builder: (context, state, _) {
        return MaterialApp(
          initialRoute: state.login == null ? '/sign' : '/',
          routes: {'/sign': (context) => Login(), '/': (context) => HomePage()},
        );
      },
    );
  }
}
