import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
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
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  Future<void> fetchOrders() async {
    final url = Uri.parse(
        'https://shop-app-2e882-default-rtdb.firebaseio.com/orders/.json');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>?;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, order) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: order['amount'],
          dateTime: DateTime.parse(order['dateTime']),
          products: (order['products'] as List<dynamic>)
              .map(
                (prod) => CartItem(
                  id: prod['id'],
                  title: prod['title'],
                  quantity: prod['quantity'],
                  price: prod['price'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://shop-app-2e882-default-rtdb.firebaseio.com/orders.json');
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cartProd) => {
                    'id': cartProd.id,
                    'title': cartProd.title,
                    'price': cartProd.price,
                    'quantity': cartProd.quantity,
                  })
              .toList(),
        }));
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timeStamp,
      ),
    );
    notifyListeners();
  }
}
