import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({Key? key}) : super(key: key);

// var _isLoading = false;
// @override
// void initState() {
//   setState(() {
//     _isLoading = true;
//   });
//   Provider.of<Orders>(context, listen: false).fetchOrders().then(
//         (_) => setState(() {
//           _isLoading = false;
//         }),
//       );
//   super.initState();
// }
//  @override
// void initState() {
//   Future.delayed(Duration.zero)
//       .then((_) => Provider.of<Orders>(context, listen: false,).fetchOrders(),);
//   super.initState();
// }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provide r.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchOrders(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return const Center(
                  child: Text('An Error Occurred!'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (context, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (context, i) => OrderItem(orderData.orders[i]),
                  ),
                );
              }
            }
          },
        )
        //  const Center(
        //     child: CircularProgressIndicator(),
        //   ),

        );
  }
}
