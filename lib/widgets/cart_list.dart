import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ecommerce/models/shopping_cart.dart';
import 'package:ecommerce/models/item.dart';

class CartListWidget extends StatefulWidget {
  final ShoppingCart cart;
  CartListWidget({super.key, required this.cart});
  @override
  State<StatefulWidget> createState() {
    return _CartListWidgetState();
  }
}

class _CartListWidgetState extends State<CartListWidget> {
  static const platform = MethodChannel('camellabs.com/payment');
  Future<void> _checkout() async {
    await platform.invokeMethod('charge', widget.cart.toMap);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    widget.cart.items.forEach((c) {
      items.add(_CartListItemWidget(
        item: c,
      ));
      items.add(const Padding(
        padding: EdgeInsets.only(top: 8.0),
      ));
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Cart'),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () => this._checkout(),
              child: const Text("Checkout"),
            ),
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(color: Color(0xfff0eff4)),
            child: Stack(
              children: <Widget>[
                ListView(
                  padding: const EdgeInsets.only(bottom: 64),
                  children: items,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 64,
                  child: _CartListSummaryFooterWidget(
                    totalPrice: widget.cart.formattedTotalPrice,
                  ),
                )
              ],
            )));
  }
}

class _CartListSummaryFooterWidget extends StatelessWidget {
  final String totalPrice;

  const _CartListSummaryFooterWidget({required this.totalPrice});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Color(0XFFF4F4F4),
            border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: Row(
            children: <Widget>[
              Text(
                'Total',
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: Text(totalPrice,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.labelLarge //subhead
                      ))
            ],
          )),
        ));
  }
}

class _CartListItemWidget extends StatelessWidget {
  final Item item;
  const _CartListItemWidget({required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Colors.grey, width: 0.5),
              bottom: BorderSide(color: Colors.grey, width: 0.5))),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 64,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(item.imagepath),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
          ),
          Expanded(
              child: Text(
            item.name,
            style: const TextStyle(
              fontSize: 15,
            ),
            // Theme.of(context).textTheme.titleLarge.apply(fontSizeFactor: 0.75),
          )),
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
          ),
          Text(
            item.formattedPrice,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.labelLarge, //.subhead
          )
        ],
      ),
    );
  }
}
