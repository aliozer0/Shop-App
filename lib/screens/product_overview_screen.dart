import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import '../widgets/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
        ),
        body: ProductsGrid(loadedProducts: loadedProducts));
  }
}

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    super.key,
    required this.loadedProducts,
  });

  final List<Product> loadedProducts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: loadedProducts.length,
      itemBuilder: ((context, index) => ProductItem(
            loadedProducts[index].id,
            loadedProducts[index].title,
            loadedProducts[index].imageUrl,
          )),
    );
  }
}
