import 'package:flutter/material.dart';
import 'package:tp_e_commerce/presentation/widgets/drawer_widget.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalog"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            childAspectRatio: 0.75, // item shape
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: 8, // number of fake items
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Fake image placeholder
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      child: const Icon(
                        Icons.image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  // Title
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Product Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Price
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 10,
                    ),
                    child: Text(
                      "€29.99",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
