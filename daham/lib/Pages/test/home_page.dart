import 'package:daham/Appstate/appstate.dart';
import 'package:daham/app_material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('HomePage'),
            Consumer<AppState>(
              builder: (context, value, _) {
                return Text('Login : ${value.login}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
