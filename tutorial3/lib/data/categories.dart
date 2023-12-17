import 'package:flutter/material.dart';

import '../models/category.dart';

const categories = {
  Categories.vegetables: Category(
    'Vegetables',
    Colors.lightGreen,
  ),
  Categories.fruit: Category(
    'Fruit',
    Colors.yellow,
  ),
  Categories.meat: Category(
    'Meat',
    Colors.redAccent,
  ),
  Categories.dairy: Category(
    'Dairy',
    Colors.blue,
  ),
  Categories.carbs: Category(
    'Carbs',
    Colors.black12,
  ),
  Categories.sweets: Category(
    'Sweets',
    Colors.pinkAccent,
  ),
  Categories.spices: Category(
    'Spices',
    Colors.deepOrange,
  ),
  Categories.convenience: Category(
    'Convenience',
    Colors.purpleAccent,
  ),
  Categories.hygiene: Category(
    'Hygiene',
    Colors.indigo,
  ),
  Categories.others: Category(
    'Other',
    Colors.teal,
  ),
};
