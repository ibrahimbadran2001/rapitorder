import 'package:flutter/cupertino.dart';
class Order {
  String? name ;
  double itemPrice;
  double price;
  int count;
  double totalPrice;
  Order(
  {
   this.name,
    this.itemPrice=0,
    required this.price,
    this.count=0,
    this.totalPrice=0,
});

}

