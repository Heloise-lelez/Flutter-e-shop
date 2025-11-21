import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_e_commerce/data/models/product.dart';
import 'package:tp_e_commerce/data/services/cart_service.dart';

class CheckoutPage extends StatefulWidget {
  final List<Product> cart;

  const CheckoutPage({super.key, required this.cart});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  // Simple payment fields
  final _nameController = TextEditingController();
  final _cardController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double total = widget.cart.fold(0, (sum, item) => sum + item.price);

    void completeOrder() {
      if (!_formKey.currentState!.validate()) return;

      // Clear cart using CartService
      CartService().clearCart();

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Payment Successful'),
          content: Text(
            'Your order has been created.\nTotal: ${total.toStringAsFixed(2)} €',
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // CART SUMMARY
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      itemCount: widget.cart.length,
                      separatorBuilder: (_, __) => Divider(),
                      itemBuilder: (_, index) {
                        final product = widget.cart[index];
                        return Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product.imageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '${product.price.toStringAsFixed(2)} €',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // PAYMENT FORM
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration:
                            const InputDecoration(labelText: "Cardholder Name"),
                        validator: (v) => v!.isEmpty
                            ? "Please enter the cardholder name"
                            : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _cardController,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: "Card Number"),
                        validator: (v) {
                          if (v!.isEmpty)
                            return "Please enter your card number";
                          if (v.length < 16) return "Card number is too short";
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _expiryController,
                              decoration:
                                  const InputDecoration(labelText: "MM/YY"),
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              controller: _cvcController,
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(labelText: "CVC"),
                              validator: (v) =>
                                  v!.length < 3 ? "Invalid CVC" : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'Total: ${total.toStringAsFixed(2)} €',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: completeOrder,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Pay Securely',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
