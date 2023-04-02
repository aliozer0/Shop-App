import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';
import '../widgets/product_item.dart';
import '../widgets/products_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: () {},
              itemBuilder: (_) => [
                    PopupMenuItem(child: Text('Only Favorite '), value: 0),
                    PopupMenuItem(
                      child: Text('Show All'),
                      value: 1,
                    )
                  ])
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
