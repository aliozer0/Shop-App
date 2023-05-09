import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    Product(
      id: 'p4',
      title: 'T-shirt',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2012/04/24/11/18/fashion-39388_960_720.png',
    ),
    Product(
      id: 'p4',
      title: 'Jacket',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2021/12/24/20/17/fashion-6891713_960_720.png',
    ),
    Product(
      id: 'p4',
      title: 'white Shirt',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2021/11/01/05/57/shirt-6759468_960_720.png',
    ),
    Product(
      id: 'p4',
      title: 'Ring',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://www.hooyo.com.tr/1/79322-storage_Ins-d%C3%BCzensiz-a%C3%A7%C4%B1k-halka-kore-vintage-basit-ayta%C5%9F%C4%B1/pic.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Necklace',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://png.pngtree.com/png-clipart/20230426/original/pngtree-blue-fashion-jewelry-necklace-pendant-png-image_9103030.png',
    ),
    Product(
      id: 'p4',
      title: 'Earring',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://www.ulusanmotor.com.tr/Rakol-parlak-beyaz-k%C3%BCbik-zirkonya-basit-daire-hoop-thumb/2_uploads-66871.jpeg',
    ),
  ];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> fetchAndSetProducts() async {
    try {
      var url = Uri.https(
          'https://shoop-bdcc1-default-rtdb.europe-west1.firebasedatabase.app',
          '/products.json');

      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'].toString(),
          description: prodData['description']?.toString() ?? '',
          price: double.parse(prodData['price'].toString()),
          isFavorite: prodData['isFavorite'] as bool,
          imageUrl: prodData['imageUrl'] as String,
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      print('Hata oluştu: $error');
    }
  }

/*

  Future<void> fetchAndSetProducts() async {
    var url = Uri.https(
      'https://shopapp-b4f6d-default-rtdb.firebaseio.com/products.json',
    );

    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      url = Uri.parse(
        'https://shopapp-b4f6d-default-rtdb.firebaseio.com/products.json',
      );
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);

      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.insert(
            0,
            Product(
              id: prodId,
              title: prodData['title'],
              price: prodData['price'].toDouble(),
              description: prodData['description'],
              imageUrl: prodData['imageUrl'],
              isFavorite:
                  favoriteData == null ? false : favoriteData[prodId] ?? false,
            ));
      });

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
    final url = Uri.parse(
        'https://shopapp-b4f6d-default-rtdb.firebaseio.com/products.json');
*/
  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://shoop-bdcc1-default-rtdb.europe-west1.firebasedatabase.app/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.https(
          'https://shoop-bdcc1-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.https(
        'https://shoop-bdcc1-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
