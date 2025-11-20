import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_e_commerce/data/models/product.dart';
import 'package:tp_e_commerce/data/services/cart_service.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  final User? user;

  const ProductDetails({required this.product, required this.user, super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          "${product.price.toStringAsFixed(2)} €",
          style: const TextStyle(fontSize: 20, color: Colors.green),
        ),
        const SizedBox(height: 16),
        Text(product.description),
        const SizedBox(height: 16),
        if (user != null) ...[
          ElevatedButton(
            onPressed: () {
              CartService().addProduct(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Row(
                  children: [
                    Text('${product.name} added to cart'),
                    const SizedBox(width: 8),
                    TextButton(
                        onPressed: () {
                          context.go("/cart");
                        },
                        child: const Text("Go to Cart"))
                  ],
                )),
              );
            },
            child: const Text("Add to Cart"),
          ),
        ] else
          Column(children: [
            const Text("Login to add items to your cart."),
            const SizedBox(height: 8),
            OutlinedButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text("Login"))
          ]),
      ],
    );
  }
}
