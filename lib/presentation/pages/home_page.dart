import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_e_commerce/presentation/widgets/drawer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<void> registerUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User registered: ${userCredential.user?.uid}');
    } on FirebaseAuthException catch (e) {
      print('Registration failed: ${e.message}');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    void onLoginPressed() => context.go('/login');
    void onRegisterPressed() => context.go('/register');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matcha Shop'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: StreamBuilder<User?>(
          stream: _auth.authStateChanges(),
          builder: (context, snapshot) {
            final user = snapshot.data;
            print(snapshot);
            if (user != null) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome, ${user.email}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await signOut();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logged out')),
                      );
                    },
                    child: const Text('Logout'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      context.go('/catalog');
                    },
                    child: const Text('Go to Catalog'),
                  ),
                ],
              );
            }

            // If not logged in, show login/register buttons
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Welcome to Matcha Shop',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onLoginPressed,
                  child: const Text('Login'),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: onRegisterPressed,
                  child: const Text('Register'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
