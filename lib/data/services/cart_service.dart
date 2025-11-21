import '../models/cart_item.dart';
import '../models/product.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addProduct(Product product) {
    final index =
        _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }
  }

  void removeProduct(Product product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);
  }

  void decreaseQuantity(Product product) {
    final index =
        _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }
    }
  }

  void clearCart() => _cartItems.clear();

  double get totalPrice =>
      _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
}
