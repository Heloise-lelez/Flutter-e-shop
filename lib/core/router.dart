import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../presentation/pages/login_page.dart' as login;
import '../presentation/pages/register_page.dart' as register;
import '../presentation/pages/home_page.dart' as home;
import '../presentation/pages/catalog_page.dart' as catalog;

final router = GoRouter(
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    final user = FirebaseAuth.instance.currentUser;
    final bool loggedIn = user != null;

    final isLoggingIn = state.matchedLocation == '/login';
    final isRegistering = state.matchedLocation == '/register';
    final isCatalog = state.matchedLocation == '/catalog';

    if (!loggedIn && isCatalog) {
      return '/login';
    }

    if (loggedIn && (isLoggingIn || isRegistering)) {
      return '/';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const home.HomePage(),
    ),
    GoRoute(
      path: '/catalog',
      name: 'catalog',
      builder: (context, state) => const catalog.CatalogPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => login.LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => register.RegisterPage(),
    ),
  ],
);
