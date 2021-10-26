import 'package:flutter/foundation.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];
  void addOrder(List<CartItem> cartProducts, double total) => {
        _orders.insert(
          0,
          OrderItem(
            id: (cartProducts.length + 1).toString(),
            amount: total,
            products: cartProducts,
            dateTime: DateTime.now(),
          ),
        ),
        notifyListeners(),
      };
}