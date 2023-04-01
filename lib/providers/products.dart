import 'package:flutter/material.dart';
import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbekQCXiuZlve-prs3twqcykJYcwzfsFbudA&usqp=CAU',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://www.cavani.co.uk/images/house-of-cavani-caridi-beige-slim-fit-trousers-p726-25956_zoom.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnohxJsNz57ff0Yk3kWs7b9yDoY3Uj3UOA5Q&usqp=CAU',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVH931ZlGNHOQgiuKkpB6-G-IBKg0mq5jdBw&usqp=CAU',
    ),
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbekQCXiuZlve-prs3twqcykJYcwzfsFbudA&usqp=CAU',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://www.cavani.co.uk/images/house-of-cavani-caridi-beige-slim-fit-trousers-p726-25956_zoom.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnohxJsNz57ff0Yk3kWs7b9yDoY3Uj3UOA5Q&usqp=CAU',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVH931ZlGNHOQgiuKkpB6-G-IBKg0mq5jdBw&usqp=CAU',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  void addProduct() {
    notifyListeners();
  }
}
