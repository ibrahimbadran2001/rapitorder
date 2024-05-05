import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'modulesorder.dart';

int counter = 1;
List<Color> gradientColors = const [
  Color.fromRGBO(249, 136, 31, 1),
  Color.fromRGBO(255, 119, 76, 1)
];
LinearGradient? linergradientColors = LinearGradient(
  colors: gradientColors,
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

List<Order> orders = [
  Order(
    name: 'Danial',
    itemPrice: 20,
    count: 1, price: 20,
  ),
  Order(
    name: 'dodo',
    itemPrice: 50,
    count: 1, price: 50,
  ),
  Order(
    name: 'dsijd',
    itemPrice: 100,
    count: 1, price: 100,
  ),
  Order(
    name: 'dsijd',
    itemPrice: 100,
    count: 1, price: 100,
  ),Order(
    name: 'dsijd',
    itemPrice: 100,
    count: 1, price: 100,
  ),Order(
    name: 'dsijd',
    itemPrice: 100,
    count: 1, price: 100,
  ),Order(
    name: 'dsijd',
    itemPrice: 100,
    count: 1, price: 100,
  ),Order(
    name: 'dsijd',
    itemPrice: 100,
    count: 1, price: 100,
  ),Order(
    name: 'dsijd',
    itemPrice: 100,
    count: 1, price: 100,
  ),Order(
    name: 'dsijd',
    itemPrice: 100,
    count: 1, price: 100,
  ),Order(
    name: 'dsijd',
    itemPrice: 100,
    count: 1, price: 100,
  ),Order(
    name: 'dsijd',
    itemPrice: 100,
    count: 1, price: 100,
  ),Order(
    name: 'dsijd',
    itemPrice: 100,
    count: 1, price: 100,
  ),
];
