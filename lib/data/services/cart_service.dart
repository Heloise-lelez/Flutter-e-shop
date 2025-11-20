import '../models/product.dart';

class CartService {
  // Singleton
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addProduct(Product product) {
    _cartItems.add(product);
  }

  void removeProduct(Product product) {
    _cartItems.remove(product);
  }

  void clearCart() {
    _cartItems.clear();
  }

  double get totalPrice => _cartItems.fold(0, (sum, item) => sum + item.price);

  List<Product>? get items => null;
}
