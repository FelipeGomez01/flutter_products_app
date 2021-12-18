import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class ProductsService extends ChangeNotifier
{
  final String _baseUrl = 'curso-flutter-65943-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  bool isLoading = true;
  late Product selectedProduct;
  bool isSaving = false;
  File? newPictureFile;

  ProductsService()
  {
    loadProducts();
  }

  Future <List<Product>> loadProducts() async
  {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl,'producto.json');
    final resp = await http.get(url);

    final Map<String,dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;

      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();

    return products;
  }

  Future saveOrCreateProduct(Product product) async
  {
    isSaving = true;
    notifyListeners();

    if(product.id == null)
    {
      await createProduct(product);
    }
    else
    {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async
  {
    final url = Uri.https(_baseUrl,'producto/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    notifyListeners();

    return product.id!;
  }

  Future<String> createProduct(Product product) async
  {
    final url = Uri.https(_baseUrl,'producto.json');
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];

    products.add(product);

    return '';
  }

  void updateSelectedProductImage(String path)
  {
    selectedProduct.picture = path;
    print('selectedProduct.picture: ${selectedProduct.picture}');
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async
  {
    if(newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/curso-flutter-udemy/image/upload?upload_preset=b5igg51r');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201)
    {
      print('error.');
      print(resp.body);
      return null;
    }

    newPictureFile = null;

    final decodeData = json.decode(resp.body);

    return decodeData['secure_url'];
  }
}