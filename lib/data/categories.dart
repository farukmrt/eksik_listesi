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
  Categories.sweets: Category(
    'Atıştırmalıklar',
    Color.fromARGB(255, 255, 149, 0),
  ),
  Categories.spices: Category(
    'Baharat',
    Color.fromARGB(255, 255, 187, 0),
  ),
  Categories.convenience: Category(
    'WC',
    Color.fromARGB(255, 191, 0, 255),
  ),
  Categories.hygiene: Category(
    'Hijyen',
    Color.fromARGB(255, 149, 0, 255),
  ),
  Categories.other: Category(
    'Diğer',
    Color.fromARGB(255, 0, 225, 255),
  ),
};
