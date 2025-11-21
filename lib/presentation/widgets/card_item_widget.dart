import 'package:flutter/material.dart';
import '../../data/models/cart_item.dart';
import '../../data/services/cart_service.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onUpdate;

  const CartItemWidget(
      {super.key, required this.cartItem, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    final cartService = CartService();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Image.network(cartItem.product.imageUrl, width: 60),
            const SizedBox(width: 16),
            Expanded(child: Text(cartItem.product.name)),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    cartService.decreaseQuantity(cartItem.product);
                    onUpdate();
                  },
                ),
                Text('${cartItem.quantity}',
                    style: const TextStyle(fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    cartService.addProduct(cartItem.product);
                    onUpdate();
                  },
                ),
              ],
            ),
            Text('${cartItem.totalPrice.toStringAsFixed(2)} €'),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                cartService.removeProduct(cartItem.product);
                onUpdate();
              },
            ),
          ],
        ),
      ),
    );
  }
}
