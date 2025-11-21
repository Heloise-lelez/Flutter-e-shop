import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_e_commerce/presentation/widgets/drawer_widget.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _register() async {
    // Validate fields
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields.';
      });
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Optional: update display name
      await userCredential.user?.updateDisplayName(_nameController.text.trim());

      setState(() {
        _errorMessage = 'Registration successful!';
      });

      context.go('/'); // navigate to home
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'Unknown error';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
              width: 380, // same width as login form
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
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name *',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email *',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password *',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _register,
                    child: const Text('Register'),
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
                      context.go('/login');
                    },
                    child: const Text("I already have an account"),
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
