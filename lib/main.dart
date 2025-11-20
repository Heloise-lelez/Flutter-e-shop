import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tp_e_commerce/data/services/auth_service.dart';
import 'firebase_options.dart';
import 'core/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          return MaterialApp.router(
              title: 'Matcha Shop',
              routerConfig: router,
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.lightGreenAccent,
                ).copyWith(
                  tertiary: Colors.brown,
                  onTertiary: Colors.white,
                  tertiaryContainer: Colors.brown[200],
                  onTertiaryContainer: Colors.brown[900], // Dark brown
                ),
                fontFamily: 'TextFont',
                textTheme: const TextTheme(
                  headlineLarge: TextStyle(fontFamily: 'TitleFont'),
                ),
                appBarTheme: AppBarTheme(
                  titleTextStyle: TextStyle(
                    fontFamily: 'TitleFont',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ));
        });
  }
}
