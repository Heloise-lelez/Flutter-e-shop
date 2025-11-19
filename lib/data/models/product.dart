// ...existing code...
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// MODEL - Structure des données
class Product {
  final String id;
  final String title;
  final double price;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.images = const [],
  });

  // Optionnel : constructeur depuis JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : 0.0,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}

// Interface de repository pour récupérer les produits
abstract class ProductRepository {
  Future<List<Product>> fetchProducts();
}

// Implémentation de démonstration (mock)
class MockProductRepository implements ProductRepository {
  @override
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      Product(id: '1', title: 'Chaussures', price: 59.99, images: []),
      Product(id: '2', title: 'T-shirt', price: 19.99, images: []),
      Product(id: '3', title: 'Sac', price: 39.50, images: []),
    ];
  }
}

// VIEW-MODEL - Logique métier
class CatalogViewModel extends ChangeNotifier {
  final ProductRepository _repository;

  CatalogViewModel({required ProductRepository repository})
      : _repository = repository;

  List<Product> _products = [];
  List<Product> get products => _products;

  Future<void> loadProducts() async {
    _products = await _repository.fetchProducts();
    notifyListeners(); // Met à jour l'UI
  }
}

// Simple card pour afficher un produit
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: product.images.isNotEmpty
          ? Image.network(product.images.first,
              width: 56, height: 56, fit: BoxFit.cover)
          : const SizedBox(width: 56, height: 56, child: Icon(Icons.image)),
      title: Text(product.title),
      subtitle: Text('${product.price.toStringAsFixed(2)} €'),
    );
  }
}

// VIEW - Interface utilisateur
class CatalogPage extends StatelessWidget {
  final ProductRepository? repository;
  const CatalogPage({Key? key, this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CatalogViewModel>(
      create: (_) {
        final vm =
            CatalogViewModel(repository: repository ?? MockProductRepository());
        vm.loadProducts();
        return vm;
      },
      child: Consumer<CatalogViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.products.length,
            itemBuilder: (context, index) {
              return ProductCard(viewModel.products[index]);
            },
          );
        },
      ),
    );
  }
}
// ...existing code...