import 'package:flutter/material.dart';
import 'dart:convert';
import './product.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbekQCXiuZlve-prs3twqcykJYcwzfsFbudA&usqp=CAU',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://www.cavani.co.uk/images/house-of-cavani-caridi-beige-slim-fit-trousers-p726-25956_zoom.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnohxJsNz57ff0Yk3kWs7b9yDoY3Uj3UOA5Q&usqp=CAU',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you wants.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://encrypted-tbn0da.gstatic.com/images?q=tbn:ANd9GcTVH931ZlGNHOQgiuKkpB6-G-IBKg0mq5jdBw&usqp=CAU',
    // ),
  ];
  var _showFavoritesOnly = false;

  List<Product> get favoriteItem {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  List<Product> get items {
    if (_showFavoritesOnly) {
      return _items.where((prodItem) => prodItem.isFavorite).toList();
    }
    return [..._items];
  }

  Product findbyId(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    var url = Uri.parse(
        'https://shopapp-b4f6d-default-rtdb.firebaseio.com/products.json');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      extractedData.forEach(
        (prodId, prodData) {
          loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'].toString(),
            description: prodData['description'],
            imageUrl: prodData['imageData'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite'],
          ));
        },
      );
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {}
  }

  Future<void> addProduct(Product product) async {
    const url =
        'https://shopapp-b4f6d-default-rtdb.firebaseio.com/products.json'
            as String;
    try {
      final response = await http
          .post(
        Uri.parse(url),
        body: json.encode({
          'title': product.title,
          'destription': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite
        }),
      )
          .then((response) {
        print(json.decode(response.body));
        final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          price: product.price,
          description: product.description,
          imageUrl: product.imageUrl,
        );
        _items.add(newProduct);
        // _items.insert(0, newProduct); //  at the start of list.

        notifyListeners();
      });
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex > 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
