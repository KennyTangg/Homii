import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  final String price;
  final String imagePath;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });

  double get priceValue {
    // Extract numeric value from price string (e.g., "Rp 20.000" -> 20000)
    String cleanPrice = price.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(cleanPrice) ?? 0.0;
  }

  double get totalPrice => priceValue * quantity;
}

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  
  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);
  
  double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere((i) => i.id == item.id);
    
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  void updateQuantity(String itemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(itemId);
      return;
    }
    
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      _items[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  void incrementQuantity(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      // Limit quantity to maximum of 99
      if (_items[index].quantity < 99) {
        _items[index].quantity++;
        notifyListeners();
      }
    }
  }

  void decrementQuantity(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
        notifyListeners();
      } else {
        // Remove item when quantity reaches 0
        removeItem(itemId);
      }
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool isInCart(String itemId) {
    return _items.any((item) => item.id == itemId);
  }

  int getQuantity(String itemId) {
    final item = _items.firstWhere(
      (item) => item.id == itemId,
      orElse: () => CartItem(id: '', name: '', price: '', imagePath: '', quantity: 0),
    );
    return item.quantity;
  }

  String get formattedTotalPrice {
    final total = totalPrice;
    // Format Indonesian Rupiah with proper thousands separator
    String formattedNumber = total.toStringAsFixed(0);

    // Add thousands separator (dots for Indonesian format)
    if (formattedNumber.length > 3) {
      String result = '';
      int count = 0;
      for (int i = formattedNumber.length - 1; i >= 0; i--) {
        if (count == 3) {
          result = '.$result';
          count = 0;
        }
        result = formattedNumber[i] + result;
        count++;
      }
      formattedNumber = result;
    }

    return 'Rp $formattedNumber';
  }
}
