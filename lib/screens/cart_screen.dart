import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/carts_item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(children: [
        Card(
          margin: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Chip(
                label: Text(
                  '\$${cart.totalAmount}',
                ),
                backgroundColor: Colors.amber,
              ),
              TextButton(onPressed: () {}, child: Text('ORDER NOW'))
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (ctx, i) => ci.CartsItem(
            cart.items.values.toList()[i].id,
            cart.items.values.toList()[i].title,
            cart.items.values.toList()[i].price,
            cart.items.values.toList()[i].quantity,
          ),
        ))
      ]),
    );
  }
}
