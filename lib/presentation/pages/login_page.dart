import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_e_commerce/presentation/widgets/drawer_widget.dart';

import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print('User logged in: ${userCredential.user?.uid}');
      setState(() {
        _errorMessage = 'Login successful!';
      });
      context.go('/');
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'Unknown error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 8, // soft shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: 380, // reduce the width of the card
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/animation/matcha_tea.json',
                    width: 160,
                    height: 160,
                    fit: BoxFit.contain,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _errorMessage,
                    style: TextStyle(
                      color: _errorMessage.contains('successful')
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      context.go('/register');
                    },
                    child: const Text('Create an Account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
