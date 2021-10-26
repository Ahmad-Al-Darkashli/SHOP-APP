import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return GridTile(
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: product.id,
        ),
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        leading: Consumer<Product>(
          //  child: ,
          builder: (ctx, product, _) => IconButton(
            icon: Icon(
              product.isFavorate ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () => product.toggleFavoriteStatus(),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        backgroundColor: Colors.black54,
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () =>
              cart.addItem(product.id, product.price, product.title),
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
