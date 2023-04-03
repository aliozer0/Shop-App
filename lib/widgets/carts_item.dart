import 'package:flutter/material.dart';

class CartsItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantety;

  CartsItem(this.id, this.title, this.price, this.quantety);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(
                child: Text('\$${price}'),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total :  \$${(price * quantety)}'),
          trailing: Text('$quantety x'),
        ),
      ),
    );
  }
}
