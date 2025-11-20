import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Text("Menu", style: TextStyle(fontSize: 22)),
          ),
          ListTile(
              title: const Text("Home"),
              onTap: () => {
                    Navigator.pop(context),
                    context.go('/'),
                  }),
          ListTile(
              title: const Text("Colors"),
              onTap: () => {
                    Navigator.pop(context),
                    context.go('/colors'),
                  }),
          ListTile(
              title: const Text("Catalog"),
              onTap: () => {
                    Navigator.pop(context),
                    context.go('/catalog'),
                  }),
          const Spacer(),
          if (user == null) ...[
            ListTile(
                leading: const Icon(Icons.login),
                title: const Text("Login"),
                onTap: () => {
                      Navigator.pop(context),
                      context.go('/login'),
                    }),
            ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text("Register"),
                onTap: () => {
                      Navigator.pop(context),
                      context.go('/register'),
                    }),
          ] else ...[
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text("My Cart"),
              onTap: () async {
                Navigator.pop(context);
                context.go('/cart');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                context.go('/');
              },
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
