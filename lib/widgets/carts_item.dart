import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartsItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantety;

  CartsItem(this.id, this.productId, this.title, this.price, this.quantety);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Dismissible(
      key: new ValueKey(cart.items),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      onDismissed: (direction) {
        return cart.removeItem(productId);
      },
      direction: DismissDirection.endToStart,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    '\$${price}',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total :  \$${(price * quantety)}'),
            trailing: Text('$quantety x'),
          ),
        ),
      ),
    );
  }
}
