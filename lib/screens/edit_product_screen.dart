import 'package:flutter/material.dart';
import 'package:shop/screens/user_products_screen.dart';
import '../providers/products.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';

class EditProductScren extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  State<EditProductScren> createState() => _EditProductScrenState();
}

class _EditProductScrenState extends State<EditProductScren> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(title: '', description: '', imageUrl: '', price: 0, id: '');
  var _isInit = true;
  var _isLoading = false;
  var _initValues = {
    'title': '',
    'descirption': '',
    'price': '',
    'imageUrl': '',
  };
/*



@override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findbyId(productId);
        _initValues = {
          'title': _editedProduct.title,
          'descirption': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }
*/
  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final productId = ModalRoute.of(context)!.settings.arguments as String;
        _editedProduct =
            Provider.of<Products>(context, listen: false).findbyId(productId);
        _initValues = {
          'title': _editedProduct.title,
          'descirption': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    _imageFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();

    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    //not to add new product if edited the old
    if (_editedProduct.id.isNotEmpty) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
    if (_editedProduct.id.isEmpty) {
      //add newly added item
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .catchError((error) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An error occurred!'),
                  content: Text('Someting went wrong'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Okay'),
                    )
                  ],
                ));
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
    // print(_editedProduct.id);
    // print(_editedProduct.imageUrl);
    // print(_editedProduct.price);
    print(_editedProduct.id.isEmpty);
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(color: Colors.blue),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _initValues['title'],
                        decoration: InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        validator: (isValue) {
                          if (isValue!.isEmpty) {
                            return 'Please provider a value.';
                          } else
                            return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
                            title: value.toString(),
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl,
                            price: _editedProduct.price,
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['price'],
                        decoration: InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        validator: (isValue) {
                          if (isValue!.isEmpty) {
                            return 'Please enter a price.';
                          }
                          if (double.tryParse(isValue) == null) {
                            return 'Please enter a valid number.';
                          }
                          if (double.parse(isValue) <= 0) {
                            return 'Please enter a number greater than zero.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              imageUrl: _editedProduct.imageUrl,
                              price: double.parse(value.toString()));
                        },
                      ),
                      TextFormField(
                          initialValue: _initValues['description'],
                          decoration: InputDecoration(labelText: 'Description'),
                          maxLength: 25,
                          keyboardType: TextInputType.multiline,
                          focusNode: _descriptionFocusNode,
                          validator: (isValue) {
                            if (isValue!.isEmpty) {
                              return 'Please enter e destription';
                            }
                            if (isValue.length <= 10) {
                              return 'Should be at least 10 characters long. ';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                                id: _editedProduct.id,
                                isFavorite: _editedProduct.isFavorite,
                                title: _editedProduct.title,
                                description: value.toString(),
                                imageUrl: _editedProduct.imageUrl,
                                price: _editedProduct.price);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocusNode);
                          }),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                            ),
                            child: _imageUrlController.text.isEmpty
                                ? Text('Enter a URL')
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Image URL'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageFocusNode,
                              validator: (isValue) {
                                if (isValue!.isEmpty) {
                                  return 'Plesae enter an image URL';
                                }
                                if (!isValue.startsWith('http') ||
                                    !isValue.startsWith('https')) {
                                  return 'Please enter a valid URl';
                                }
                                if (!isValue.endsWith('png') &&
                                    !isValue.endsWith('jpg') &&
                                    !isValue.endsWith('jpeg') &&
                                    !isValue.endsWith('heic')) {
                                  return '.jpg, jpeg, .png, .heic format is supprted only';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) => _saveForm(),
                              onSaved: (value) {
                                _editedProduct = Product(
                                    id: _editedProduct.id,
                                    isFavorite: _editedProduct.isFavorite,
                                    title: _editedProduct.title,
                                    description: _editedProduct.description,
                                    imageUrl: value.toString(),
                                    price: _editedProduct.price);
                              },
                              onEditingComplete: () {
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
