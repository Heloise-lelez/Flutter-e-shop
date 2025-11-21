import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tp_e_commerce/data/services/cart_service.dart';
import 'package:tp_e_commerce/presentation/pages/checkout_page.dart';

import '../presentation/pages/login_page.dart' as login;
import '../presentation/pages/register_page.dart' as register;
import '../presentation/pages/home_page.dart' as home;
import '../presentation/pages/catalog_page.dart' as catalog;
import '../presentation/pages/product_detail_page.dart' as product_detail;
import '../presentation/pages/colors_page.dart' as colors;
import '../presentation/pages/cart_page.dart' as cart;

import '../data/models/product.dart';

final router = GoRouter(
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    final user = FirebaseAuth.instance.currentUser;
    final loggedIn = user != null;

    final goingToLogin = state.matchedLocation == '/login';
    final goingToRegister = state.matchedLocation == '/register';

    if (loggedIn && (goingToLogin || goingToRegister)) return '/';
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
      path: '/product/:id',
      name: 'product',
      builder: (context, state) {
        final product = state.extra as Product;
        return product_detail.ProductPage(product: product);
      },
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
    GoRoute(
      path: '/colors',
      name: 'colors',
      builder: (context, state) => const colors.ColorSchemePage(),
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) => const cart.CartPage(),
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) {
        // Get only the products from CartItems
        final cartProducts =
            CartService().cartItems.map((item) => item.product).toList();
        return CheckoutPage(cart: cartProducts);
      },
    ),
  ],
);
