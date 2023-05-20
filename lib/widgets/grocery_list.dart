import 'dart:convert';

import 'package:eksik_listesi/data/categories.dart';
import 'package:eksik_listesi/data/dummy_items.dart';
import 'package:eksik_listesi/widgets/new_item.dart';
import 'package:flutter/material.dart';
import 'package:eksik_listesi/models/grocery_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  late Future<List<GroceryItem>> _loadedItems;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(
        'flutter-prep-d479b-default-rtdb.firebaseio.com', 'shopping-list.json');

    final response = await http.get(url); //throw Exception('Bir şeyler oldu');

    if (response.statusCode >= 400) {
      throw Exception('Veriler getirilemedi daha sonra tekrar deneyin');
      // setState(() {
      //   _error = 'Veri alınamadı, daha sonra tekrar deneyiniz..';
      // });
    }

    if (response.body == 'null') {
      return [];
    }
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;
      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    return loadedItems;
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https('flutter-prep-d479b-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hata, silme işlemi başarısız..'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eksik Listen'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadedItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Eksik listeniz boş'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) => Dismissible(
              onDismissed: (direction) {
                _removeItem(snapshot.data![index]);
              },
              key: ValueKey(snapshot.data![index].id),
              child: ListTile(
                title: Text(snapshot.data![index].name),
                leading: Container(
                  height: 24,
                  width: 24,
                  color: snapshot.data![index].category.color,
                ),
                trailing: Text(snapshot.data![index].quantity.toString()),
              ),
            ),
          );
        },
      ),
    );
  }
}
