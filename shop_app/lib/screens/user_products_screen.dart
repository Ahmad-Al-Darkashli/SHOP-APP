import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductScreen({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, index) => Column(
              children: [
                UserProductItem(
                  productsData.items[index].id,
                  productsData.items[index].title,
                  productsData.items[index].imageUrl,
                ),
                const Divider(
                  endIndent: 100,
                  color: Colors.green,
                  thickness: 3,
                  indent: 100,
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
