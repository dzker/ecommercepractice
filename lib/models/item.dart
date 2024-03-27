import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Item {
  String id;
  String name;
  String description;
  int price;
  bool inStock;
  String imagepath;
  Item(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.inStock,
      required this.imagepath});
  String get formattedAvailability => inStock ? "Available" : "Out of stock";
  String get formattedPrice => Item.formatter.format(price);
  Color get availabilityColor => inStock ? Colors.grey : Colors.red;
  static final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: "Rp ");
  static List<Item> get dummyItems => [
        Item(
            id: "1",
            name: "iPhone X (Product RED)             ",
            description: 'More magical than ever.',
            price: 12499999,
            inStock: true,
            imagepath: 'assets/images/iphonex.jpg'),
        Item(
            id: "2",
            name: "AirPods with Wireless Charging Case",
            description: 'More magical than ever.',
            price: 2999999,
            inStock: true,
            imagepath: 'assets/images/airpods.jpg'),
        Item(
            id: "3",
            name: "iPhone X Max (GOLD)",
            description: 'More magical than ever.',
            price: 18999999,
            inStock: true,
            imagepath: 'assets/images/iphonexgold.jpg'),
        Item(
            id: "4",
            name: "iPhone X (SILVER)",
            description: 'More magical than ever.',
            price: 14999999,
            inStock: true,
            imagepath: 'assets/images/iphone12.jpg'),
      ];
}
