import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_e_commerce/presentation/widgets/card_item_widget.dart';
import '../../data/services/cart_service.dart';
import '../widgets/drawer_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartService = CartService();

  @override
  Widget build(BuildContext context) {
    final cartItems = cartService.cartItems;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth >= 800; // responsive breakpoint

    if (cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Your Cart')),
        drawer: const AppDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Your cart is empty.'),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => context.go('/catalog'),
                child: const Text('Shop Now'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isWideScreen
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LEFT: product list
                  Expanded(
                    flex: 3,
                    child: ListView.separated(
                      itemCount: cartItems.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return CartItemWidget(
                          cartItem: cartItems[index],
                          onUpdate: () => setState(() {}),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 24),
                  // RIGHT: summary
                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Summary',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  '${cartService.totalPrice.toStringAsFixed(2)} €',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () =>
                                    context.push('/checkout', extra: cartItems),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                child: const Text(
                                  'Proceed to Checkout',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItemWidget(
                          cartItem: cartItems[index],
                          onUpdate: () => setState(() {}),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('${cartService.totalPrice.toStringAsFixed(2)} €',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          context.push('/checkout', extra: cartItems),
                      child: const Text('Proceed to Checkout'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
