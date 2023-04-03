import 'package:flutter/material.dart';

import '../providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/orders_item.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
          itemCount: ordersData.orders.length,
          itemBuilder: (ctx, i) => OrdersItem(ordersData.orders[i])),
    );
  }
}
