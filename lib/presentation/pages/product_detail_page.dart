import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import '../../data/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/product_details_widget.dart';
import 'package:share_plus/share_plus.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  const ProductPage({required this.product, super.key});

  void shareProduct() {
    ShareParams(
        text:
            'Check out this product: ${product.name}\nLink: ${product.imageUrl}');
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWebLayout = screenWidth >= 800;

    Widget content = SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: isWebLayout
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          product.imageUrl,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ProductDetails(product: product, user: user),
                          const SizedBox(height: 16),
                          // Android-only share button
                          if (!kIsWeb && Platform.isAndroid)
                            ElevatedButton.icon(
                              onPressed: shareProduct,
                              icon: const Icon(Icons.share),
                              label: const Text("Share"),
                            ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.imageUrl,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ProductDetails(product: product, user: user),
                    const SizedBox(height: 16),
                    // Android-only share button
                    if (!kIsWeb && Platform.isAndroid)
                      ElevatedButton.icon(
                        onPressed: shareProduct,
                        icon: const Icon(Icons.share),
                        label: const Text("Share"),
                      ),
                  ],
                ),
        ),
      ),
    );

    if (!kIsWeb && Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(product.name),
          previousPageTitle: 'Back',
        ),
        child: content,
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
        ),
        body: content,
      );
    }
  }
}
