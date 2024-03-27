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
      NumberFormat.currency(locale: 'ms_MY', symbol: "RM ");
  static List<Item> get dummyItems => [
        Item(
            id: "1",
            name: "iPhone X              ",
            description: 'More magical than ever.',
            price: 3499,
            inStock: true,
            imagepath: 'assets/images/iphonex.jpg'),
        Item(
            id: "2",
            name: "AirPods 3",
            description: 'More magical than ever.',
            price: 800,
            inStock: true,
            imagepath: 'assets/images/airpods.jpg'),
        Item(
            id: "3",
            name: "iPhone X Max (GOLD)",
            description: 'More magical than ever.',
            price: 3999,
            inStock: true,
            imagepath: 'assets/images/iphonexgold.jpg'),
        Item(
            id: "4",
            name: "iPhone X (SILVER)",
            description: 'More magical than ever.',
            price: 5499,
            inStock: true,
            imagepath: 'assets/images/iphone12.jpg'),
        Item(
            id: "5",
            name: "iPhone 13 Pro",
            description: 'More magical than ever.',
            price: 6499,
            inStock: true,
            imagepath: 'assets/images/iphone13pro.jpg'),
        Item(
            id: "5",
            name: "iPhone 15 Pro",
            description: 'More magical than ever.',
            price: 5499,
            inStock: true,
            imagepath: 'assets/images/iphone15pro.jpg'),
      ];
}
