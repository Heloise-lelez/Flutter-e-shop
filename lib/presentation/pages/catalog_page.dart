import 'package:flutter/material.dart';
import 'package:tp_e_commerce/presentation/widgets/drawer_widget.dart';
import 'package:tp_e_commerce/presentation/widgets/product_card_widget.dart';
import '../../data/models/product.dart';
import '../../data/services/api_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  late Future<List<Product>> _productsFuture;

  String? _selectedCategory; // filter
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductService.loadProducts();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Catalog",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final products = snapshot.data!;
          final categories = products.map((p) => p.category).toSet().toList();

          final filteredProducts = products.where((p) {
            final matchesCategory = _selectedCategory == null ||
                _selectedCategory!.isEmpty ||
                p.category == _selectedCategory;
            final matchesSearch = _searchQuery.isEmpty ||
                p.name.toLowerCase().contains(_searchQuery.toLowerCase());
            return matchesCategory && matchesSearch;
          }).toList();

          final searchField = Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: kIsWeb ? 500 : double.infinity,
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  // You can implement filtering here
                },
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: Icon(Icons.search,
                      color: Theme.of(context).colorScheme.primary),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondaryContainer,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none, // removes the border
                  ),
                ),
              ),
            ),
          );

          final dropdownField = Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: kIsWeb ? 500 : double.infinity,
              ),
              child: DropdownButton<String>(
                icon: Icon(Icons.filter_list,
                    color: Theme.of(context).colorScheme.primary),
                value: _selectedCategory ?? '',
                hint: const Text('Select Category'),
                items: [
                  const DropdownMenuItem(
                    value: '',
                    child: Text('All Categories'),
                  ),
                  ...categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                isExpanded: true,
              ),
            ),
          );

          return Column(
            children: [
              searchField,
              dropdownField,
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kIsWeb ? 4 : 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: kIsWeb ? 0.8 : 0.7,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: filteredProducts[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
