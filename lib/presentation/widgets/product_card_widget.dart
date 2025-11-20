import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_e_commerce/data/services/cart_service.dart';
import '../../data/models/product.dart';
import '../pages/product_detail_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductPage(product: product),
          ),
        );
      },
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // image

            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // name

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),

            // Product price

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('${product.price.toStringAsFixed(2)} €'),
            ),
            const SizedBox(height: 8),

            // cart button only if user is logged in

            if (user != null)
              Center(
                  child: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
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
              )),
          ],
        ),
      ),
    );
  }
}
