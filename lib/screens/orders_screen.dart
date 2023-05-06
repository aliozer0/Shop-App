import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

import '../providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/orders_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoaing = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoaing = true;
      });
      Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: ordersData.orders.length,
          itemBuilder: (ctx, i) => OrdersItem(ordersData.orders[i])),
    );
  }
}
