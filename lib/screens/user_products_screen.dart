import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_product_screen.dart';
import 'package:shop/widgets/app_drawer.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Products'), actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(EditProductScren.routeName);
          },
          icon: const Icon(Icons.add),
        ),
      ]),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: productsData.items.length,
              itemBuilder: (_, i) => Column(
                    children: [
                      UserProductItem(
                          productsData.items[i].id,
                          productsData.items[i].title,
                          productsData.items[i].imageUrl),
                      Divider(),
                    ],
                  )),
        ),
      ),
    );
  }
}
