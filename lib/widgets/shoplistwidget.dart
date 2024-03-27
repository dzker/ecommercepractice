import 'package:flutter/material.dart';
import 'cart_list.dart';
import 'package:ecommerce/models/shopping_cart.dart';
import 'package:ecommerce/models/item.dart';

class ShopListWidget extends StatefulWidget {
  const ShopListWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ShopListState();
  }
}

class _ShopListState extends State<ShopListWidget> {
  ShoppingCart cart = ShoppingCart();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Item> items = Item.dummyItems;
  @override
  Widget build(BuildContext context) {
    final columnCount =
        MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4;
    final width = MediaQuery.of(context).size.width / columnCount;
    const height = 400;
    List<Widget> items = [];
    for (var x = 0; x < this.items.length; x++) {
      bool isSideLine;
      if (columnCount == 2) {
        isSideLine = x % 2 == 0;
      } else {
        isSideLine = x % 4 != 3;
      }
      final item = this.items[x];
      items.add(_ShopListItem(
        item: item,
        isInCart: cart.isExists(item),
        isSideLine: isSideLine,
        onTap: (item) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          if (cart.isExists(item)) {
            cart.remove(item);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Item is removed from cart!'),
            ));
          } else if (item.inStock) {
            cart.add(item);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Item is added to cart!'),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Item is out of!'),
            ));
          }
          this.setState(() {});
        },
      ));
    }
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("Apple Store"),
        ),
        body: GridView.count(
          childAspectRatio: width / height,
          scrollDirection: Axis.vertical,
          crossAxisCount: columnCount,
          children: items,
        ),
        floatingActionButton: cart.isEmpty
            ? null
            : FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CartListWidget(
                            cart: this.cart,
                          )));
                },
                icon: const Icon(Icons.shopping_cart),
                label: Text("${cart.numOfItems}"),
              ));
  }
}

class _ShopListItem extends StatelessWidget {
  final Item item;
  final bool isInCart;
  final bool isSideLine;
  dynamic onTap;
  _ShopListItem(
      {required this.item,
      required this.isInCart,
      required this.isSideLine,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    Border border;
    if (isSideLine) {
      border = const Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
          right: BorderSide(color: Colors.grey, width: 0.5));
    } else {
      border = const Border(bottom: BorderSide(color: Colors.grey, width: 0.5));
    }
    return InkWell(
        onTap: () => onTap(item),
        child: Container(
            decoration: BoxDecoration(border: border),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Container(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(item.imagepath),
                  ),
                  height: 250,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Text(item.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold) // change using text style
                    ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Text(item.formattedPrice,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .fontSize! *
                            0.7)), //change
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Text(
                  isInCart ? "In Cart" : item.formattedAvailability,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isInCart ? Colors.blue : item.availabilityColor),
                )
              ],
            )));
  }
}
