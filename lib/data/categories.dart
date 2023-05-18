import 'package:flutter/material.dart';
import 'package:eksik_listesi/models/category.dart';

const categories = {
  Categories.vegetables: Category(
    'Sebze',
    Color.fromARGB(255, 0, 255, 128),
  ),
  Categories.fruit: Category(
    'Meyve',
    Color.fromARGB(255, 145, 255, 0),
  ),
  Categories.meat: Category(
    'Et',
    Color.fromARGB(255, 255, 102, 0),
  ),
  Categories.dairy: Category(
    'Süt Ürünleri',
    Color.fromARGB(255, 0, 208, 255),
  ),
  Categories.carbs: Category(
    'Unlu Mamüller',
    Color.fromARGB(255, 0, 60, 255),
  ),
};
