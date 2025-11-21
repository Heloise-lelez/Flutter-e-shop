import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

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
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => {
                    Navigator.pop(context),
                    context.go('/'),
                  }),
          ListTile(
              leading: const Icon(Icons.list),
              title: const Text("Catalog"),
              onTap: () => {
                    Navigator.pop(context),
                    context.go('/catalog'),
                  }),
          if (kIsWeb)
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text("Share"),
              onTap: () {
                // Copy product link to clipboard
                Clipboard.setData(const ClipboardData(
                    text: "https://flutter-e-shop.vercel.app/"));

                // Show a toast
                Fluttertoast.showToast(
                  msg: "Link copied ! ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  textColor: Colors.white,
                  fontSize: 20.0,
                );
              },
            ),
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
