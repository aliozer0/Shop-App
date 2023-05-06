import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/carts_item.dart' as ci;
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
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
                  '\$${cart.totalAmount.toStringAsFixed(2)}',
                ),
                backgroundColor: Colors.amber,
              ),
              orderButton(cart: cart)
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
            cart.items.keys.toList()[i],
            cart.items.values.toList()[i].title,
            cart.items.values.toList()[i].price,
            cart.items.values.toList()[i].quantity,
          ),
        ))
      ]),
    );
  }
}

class orderButton extends StatefulWidget {
  const orderButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<orderButton> createState() => _orderButtonState();
}

class _orderButtonState extends State<orderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrder(
                    widget.cart.items.values.toList(), widget.cart.totalAmount);
                setState(() {
                  _isLoading = false;
                });
                widget.cart.clear();
              },
        child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'));
  }
}
