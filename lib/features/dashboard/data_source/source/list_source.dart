import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:point_of_sale/core/error/error.dart';
import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/init_isar.dart';
import 'package:point_of_sale/mvvm/entities/brand.dart';
import 'package:point_of_sale/mvvm/entities/category.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProductListDataSource {
  Future<List<Product>> getProductsList();
  Future<List<Product>> getSearchedProducts(
      {required String searchQuery,
      required String category,
      required String brand});
  Future<Product?> getScannedProduct({String? barCode});
  Future<List<Category>> getCategories();
  Future<List<Brand>> getBrands();
}

class ProductListDataSourceImpl implements ProductListDataSource {
  // final Dio _dio;
  // ProductListDataSourceImpl(this._dio);

  @override
  Future<List<Product>> getProductsList() async {
    // Simulate a delay to simulate an asynchronous operation
    await Future.delayed(Duration(seconds: 1));

    final List<Map<String, dynamic>> dummyProductData = [
      {
        'id': '1',
        'name': 'Infinix Hot 11',
        'description': '6.82-inch, 64GB ROM, 4GB RAM, 5000mAh Battery',
        'category': 'Mobile Phones',
        // 'price': 149.99,
        'tax': 10.00,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'supplier': 'Infinix',
        'barcode': '1234567890',
        'images': [
          'https://fdn2.gsmarena.com/vv/bigpic/infinix-hot11.jpg',
          'https://fdn2.gsmarena.com/vv/bigpic/infinix-hot11.jpg',
        ],
        'cost_price': 120.0,
        'sale_price': 180.0,
      },
      {
        'id': '2',
        'name': 'Lenovo Legion 5',
        'description':
            '15.6" Gaming Laptop, Ryzen 7 5800H, 16GB RAM, 512GB SSD',
        'category': 'Laptops',
        // 'price': 999.99,
        'tax': 50.00,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'supplier': 'Lenovo',
        'barcode': '9876543210',
        'images': [
          'https://m.media-amazon.com/images/I/71fzx0pGY5L.jpg',
          'https://m.media-amazon.com/images/I/71fzx0pGY5L.jpg',
        ],
        'cost_price': 800.0,
        'sale_price': 1100.0,
      },
      {
        'id': '3',
        'name': 'Samsung Galaxy S21 Ultra',
        'description': '6.8-inch, 128GB ROM, 12GB RAM, 108MP Camera',
        'category': 'Mobile Phones',
        // 'price': 1199.99,
        'tax': 60.00,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'supplier': 'Samsung',
        'barcode': '5432109876',
        'images': [
          'https://cdn.dxomark.com/wp-content/uploads/medias/post-74840/samsunggalaxys21ultra5g.jpg',
          'https://cdn.dxomark.com/wp-content/uploads/medias/post-74840/samsunggalaxys21ultra5g.jpg',
        ],
        'cost_price': 950.0,
        'sale_price': 1400.0,
      },
      {
        'id': '4',
        'name': 'Dell XPS 13',
        'description': '13.3" Laptop, Intel Core i7, 16GB RAM, 512GB SSD',
        'category': 'Laptops',
        'sold_qty': 12.00,
        'available_qty': 56.00,
        // 'price': 1299.99,
        'tax': 65.00,
        'supplier': 'Dell',
        'barcode': '1357924680',
        'images': [
          'https://imageio.forbes.com/specials-images/imageserve/60ea00cc87d90d93f04af3d5/Dell-XPS-13-9310-OLED-/960x0.jpg?format=jpg&width=1440',
          'https://imageio.forbes.com/specials-images/imageserve/60ea00cc87d90d93f04af3d5/Dell-XPS-13-9310-OLED-/960x0.jpg?format=jpg&width=1440',
        ],
        'cost_price': 1050.0,
        'sale_price': 1500.0,
      },
      {
        'id': '5',
        'name': 'Canon EOS 5D Mark IV',
        'description': '30.4 MP Full Frame DSLR Camera Body',
        'category': 'Cameras',
        // 'price': 2499.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 125.00,
        'supplier': 'Canon',
        'barcode': '0246813579',
        'images': [
          'https://www.the-digital-picture.com/Images/Review/Canon-EOS-5D-Mark-IV.jpg',
          'https://www.the-digital-picture.com/Images/Review/Canon-EOS-5D-Mark-IV.jpg',
        ],
        'cost_price': 2000.0,
        'sale_price': 2800.0,
      },
      {
        'id': '6',
        'name': 'Sony PlayStation 5',
        'description': 'Next-Gen Gaming Console with Ultra HD Blu-ray Drive',
        'category': 'Gaming Consoles',
        // 'price': 499.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 25.00,
        'supplier': 'Sony',
        'barcode': '6789012345',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk4WfrU7YJMwh5UA4ISKV4e1qNxr9yBeWp02DsX4JRsE5s0CtK43u7tg5DEXKfT9l89Mg&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk4WfrU7YJMwh5UA4ISKV4e1qNxr9yBeWp02DsX4JRsE5s0CtK43u7tg5DEXKfT9l89Mg&usqp=CAU',
        ],
        'cost_price': 400.0,
        'sale_price': 600.0,
      },
      {
        'id': '7',
        'name': 'Samsung 65" QLED 4K TV',
        'description': 'Samsung 65" QLED 4K Ultra HD Smart TV',
        'category': 'Electronics',
        // 'price': 899.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 45.00,
        'supplier': 'Samsung Electronics',
        'barcode': '7890123456',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdGGv9CPExTJ0QbVveC8Nl3zSeHDRgKIcZ1aLAmBPp9zBe1ZjfTKANwAMHjICUWXwpIiI&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdGGv9CPExTJ0QbVveC8Nl3zSeHDRgKIcZ1aLAmBPp9zBe1ZjfTKANwAMHjICUWXwpIiI&usqp=CAU',
        ],
        'cost_price': 700.0,
        'sale_price': 1200.0,
      },
      {
        'id': '8',
        'name': 'Apple AirPods Pro',
        'description': 'Active Noise Cancellation for Immersive Sound',
        'category': 'Headphones',
        // 'price': 249.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 12.50,
        'supplier': 'Apple Inc.',
        'barcode': '8901234567',
        'images': [
          'https://www.apple.com/newsroom/images/tile-images/Apple_airpods-pro_new-design-102819.jpg.landing-big_2x.jpg',
          'https://www.apple.com/newsroom/images/tile-images/Apple_airpods-pro_new-design-102819.jpg.landing-big_2x.jpg',
        ],
        'cost_price': 200.0,
        'sale_price': 300.0,
      },
      {
        'id': '9',
        'name': 'LG 55" OLED 4K TV',
        'description': 'LG 55" OLED 4K Ultra HD Smart TV',
        'category': 'Electronics',
        // 'price': 1299.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 65.00,
        'supplier': 'LG Electronics',
        'barcode': '9012345678',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfRqMEFtDMeFRRrvoxmdl1ntDxryt6Guo13ElaPfvJhNiFBMSYrIkyZ7vJTJo2gxOrLsQ&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfRqMEFtDMeFRRrvoxmdl1ntDxryt6Guo13ElaPfvJhNiFBMSYrIkyZ7vJTJo2gxOrLsQ&usqp=CAU',
        ],
        'cost_price': 1000.0,
        'sale_price': 1500.0,
      },
      {
        'id': '10',
        'name': 'Nikon D850',
        'description': '45.7 MP FX-Format DSLR Camera Body',
        'category': 'Cameras',
        // 'price': 2999.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 150.00,
        'supplier': 'Nikon Corporation',
        'barcode': '0123456789',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZEyFT-7sBtMcbmEhSj8JtWffr8r1CXIcSIogwpQT5QAzEQla9lYwwKynn-WXMXXscbVk&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZEyFT-7sBtMcbmEhSj8JtWffr8r1CXIcSIogwpQT5QAzEQla9lYwwKynn-WXMXXscbVk&usqp=CAU',
        ],
        'cost_price': 2400.0,
        'sale_price': 3200.0,
      },
      {
        'id': '11',
        'name': 'Sony 65" 4K OLED TV',
        'description': 'Sony 65" 4K OLED Ultra HD Smart TV',
        'category': 'Electronics',
        // 'price': 1599.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 80.00,
        'supplier': 'Sony Electronics',
        'barcode': '2345678901',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLipWUykhbzpK6RN40ZXLYqCUGZgmxNf27_XDvY9C4EynYAqRS5-l3oFVty36YaLxUm0I&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLipWUykhbzpK6RN40ZXLYqCUGZgmxNf27_XDvY9C4EynYAqRS5-l3oFVty36YaLxUm0I&usqp=CAU',
        ],
        'cost_price': 950.0,
        'sale_price': 1400.0,
      },
      {
        'id': '12',
        'name': 'Bose QuietComfort 35 II',
        'description': 'Wireless Bluetooth Headphones, Noise-Cancelling',
        'category': 'Headphones',
        // 'price': 349.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 17.50,
        'supplier': 'Bose Corporation',
        'barcode': '3456789012',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2UwD3W48ujB5lx4yUZFsupq1flDrcVDHbbuvRQxFD_DnH9oK82Ud4NHBjsN33AZTNdz8&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2UwD3W48ujB5lx4yUZFsupq1flDrcVDHbbuvRQxFD_DnH9oK82Ud4NHBjsN33AZTNdz8&usqp=CAU',
        ],
        'cost_price': 280.0,
        'sale_price': 400.0,
      },
      {
        'id': '13',
        'name': 'HP Spectre x360',
        'description': '13.3" 2-in-1 Laptop, Intel Core i7, 16GB RAM, 1TB SSD',
        'category': 'Laptops',
        // 'price': 1399.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 70.00,
        'supplier': 'HP Inc.',
        'barcode': '4567890123',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlstX8gPLIW2xe3httB9Fi-nRyK5K_QbemidZfczh5nnL72sL0yaWrgskDBMKDe9C9P8A&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlstX8gPLIW2xe3httB9Fi-nRyK5K_QbemidZfczh5nnL72sL0yaWrgskDBMKDe9C9P8A&usqp=CAU',
        ],
        'cost_price': 1200.0,
        'sale_price': 1600.0,
      },
      {
        'id': '14',
        'name': 'Fitbit Charge 4',
        'description': 'Fitness and Activity Tracker with Built-in GPS',
        'category': 'Wearable Technology',
        // 'price': 129.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 6.50,
        'supplier': 'Fitbit Inc.',
        'barcode': '5678901234',
        'images': [
          'https://images-na.ssl-images-amazon.com/images/I/71smqRr0pmL._AC_SL1500_.jpg',
          'https://images-na.ssl-images-amazon.com/images/I/71smqRr0pmL._AC_SL1500_.jpg',
        ],
        'cost_price': 100.0,
        'sale_price': 150.0,
      },
      {
        'id': '15',
        'name': 'Microsoft Surface Pro 7',
        'description': '12.3" Touch-Screen, Intel Core i5, 8GB RAM, 256GB SSD',
        'category': 'Tablets',
        // 'price': 899.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 45.00,
        'supplier': 'Microsoft Corporation',
        'barcode': '6789012345',
        'images': [
          'https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6374/6374993_sd.jpg',
          'https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6374/6374993_sd.jpg',
        ],
        'cost_price': 750.0,
        'sale_price': 1100.0,
      },
      {
        'id': '16',
        'name': 'GoPro HERO9 Black',
        'description': '5K Ultra HD Action Camera',
        'category': 'Cameras',
        // 'price': 449.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 22.50,
        'supplier': 'GoPro, Inc.',
        'barcode': '7890123456',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKKf-3iAYYIqD6eoILTNK32j2hEc3qtGVwGVdQ6-Bnrl-B-xd5ZcZjf6JO_PPtCdGq540&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKKf-3iAYYIqD6eoILTNK32j2hEc3qtGVwGVdQ6-Bnrl-B-xd5ZcZjf6JO_PPtCdGq540&usqp=CAU',
        ],
        'cost_price': 400.0,
        'sale_price': 550.0,
      },
      {
        'id': '17',
        'name': 'ASUS ROG Strix Scar 17',
        'description': '17.3" Gaming Laptop, AMD Ryzen 9, 32GB RAM, 1TB SSD',
        'category': 'Laptops',
        // 'price': 2299.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 115.00,
        'supplier': 'ASUS',
        'barcode': '8901234567',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiLx4IAV2tC3svdLN0FU0wngl3iSgoqTG2yr6coZhmaMdlQwXAAoAwD2wdExebULQCmPc&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiLx4IAV2tC3svdLN0FU0wngl3iSgoqTG2yr6coZhmaMdlQwXAAoAwD2wdExebULQCmPc&usqp=CAU',
        ],
        'cost_price': 1900.0,
        'sale_price': 2600.0,
      },
      {
        'id': '18',
        'name': 'Amazon Echo Dot (4th Gen)',
        'description': 'Smart Speaker with Alexa',
        'category': 'Smart Home',
        // 'price': 49.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 2.50,
        'supplier': 'Amazon.com, Inc.',
        'barcode': '9012345678',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAKn295E_AT5R1I1-82mTUcLJgOgh9sXSEiZwvOVziMc4HqkJk7NNxnVHkD2h-CIUKVsU&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAKn295E_AT5R1I1-82mTUcLJgOgh9sXSEiZwvOVziMc4HqkJk7NNxnVHkD2h-CIUKVsU&usqp=CAU',
        ],
        'cost_price': 40.0,
        'sale_price': 60.0,
      },
      {
        'id': '19',
        'name': 'Fitbit Versa 3',
        'description': 'GPS Smartwatch with Heart Rate Monitor',
        'category': 'Wearable Technology',
        // 'price': 229.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 11.50,
        'supplier': 'Fitbit Inc.',
        'barcode': '0123456789',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRq_Rq4NepbUXFcRRa5UydrDeOLpw7yjmqq9C8q7GqCgxpf-NeVJKB59JeSboTR8VNgiOs&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRq_Rq4NepbUXFcRRa5UydrDeOLpw7yjmqq9C8q7GqCgxpf-NeVJKB59JeSboTR8VNgiOs&usqp=CAU',
        ],
        'cost_price': 180.0,
        'sale_price': 250.0,
      },
      {
        'id': '20',
        'name': 'Acer Predator Helios 300',
        'description': '15.6" Gaming Laptop, Intel i7, 16GB RAM, 512GB SSD',
        'category': 'Laptops',
        // 'price': 1199.99,
        'sold_qty': 12.00,
        'available_qty': 56.00,
        'tax': 60.00,
        'supplier': 'Acer Inc.',
        'barcode': '2345678901',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREZYG3ys-vPazdSf4BwFsFP30dwQCc2I4M5s-bk9je44hjz8IqtGiPe5RbHmgQubtxSm8&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREZYG3ys-vPazdSf4BwFsFP30dwQCc2I4M5s-bk9je44hjz8IqtGiPe5RbHmgQubtxSm8&usqp=CAU',
        ],
        'cost_price': 950.0,
        'sale_price': 1400.0,
      },
    ];

    try {
      final supabase = Supabase.instance.client;
      final session = supabase.auth.currentSession;
      print("Session: $session");
      final productsResponse = await supabase.from('products').select('*');
      print("Products==>${productsResponse}");

      final imagesResponse = await supabase.from('images').select('*');
      print("images==>${imagesResponse}");
      for (var product in productsResponse) {
        for (var image in imagesResponse) {
          if (product['id'] == image['product_id']) {
            product['images'] = [image['image0'], image['image1']];
          }
        }
      }
      print(
          "List Products:${productsResponse.map<Product>((e) => Product.fromJson(e)).toList()}");
      return productsResponse.map<Product>((e) => Product.fromJson(e)).toList();
    } catch (error) {
      throw Exception('Error during HTTP request: $error');
    }
    // final List<Product> dummyProducts =
    //     dummyProductData.map((data) => Product.fromJson(data)).toList();

    // return dummyProducts;
  }

  @override
  Future<List<Product>> getSearchedProducts(
      {required String searchQuery,
      required String category,
      required String brand}) async {
    final supabase = Supabase.instance.client;
    List searchedProducts = [];
    log('Filter Params $category,$brand,$searchQuery');
    if (category.isNotEmpty && brand.isEmpty && searchQuery.isEmpty) {
      final response =
          await supabase.from("products").select('*').eq('category', category);
      searchedProducts.addAll(response);
    }
    if (category.isEmpty && brand.isNotEmpty && searchQuery.isEmpty) {
      final response =
          await supabase.from("products").select('*').eq('supplier', brand);
      searchedProducts.addAll(response);
    }
    if (searchQuery.isNotEmpty && brand.isEmpty && category.isEmpty) {
      final response = await supabase
          .from("products")
          .select('*')
          .ilike('name', '%$searchQuery%');
      searchedProducts.addAll(response);
    }
    if (brand.isNotEmpty && category.isNotEmpty && searchQuery.isEmpty) {
      final response = await supabase
          .from("products")
          .select('*')
          .eq('supplier', brand)
          .eq('category', category);
      searchedProducts.addAll(response);
    }
    if (searchQuery.isNotEmpty && brand.isNotEmpty && category.isNotEmpty) {
      final response = await supabase
          .from("products")
          .select('*')
          .ilike('name', '%$searchQuery%')
          .eq('category', category)
          .eq('supplier', brand);
      searchedProducts.addAll(response);
    }

    if (category.isNotEmpty && brand.isEmpty && searchQuery.isNotEmpty) {
      final response = await supabase
          .from("products")
          .select('*')
          .eq('category', category)
          .ilike('name', '%$searchQuery%');
      searchedProducts.addAll(response);
    }
    if (brand.isNotEmpty && category.isEmpty && searchQuery.isNotEmpty) {
      final response = await supabase
          .from("products")
          .select('*')
          .eq('supplier', brand)
          .ilike('name', '%$searchQuery%');
      searchedProducts.addAll(response);
    }

    if (category.isEmpty && brand.isEmpty && searchQuery.isEmpty) {
      final response = await supabase.from("products").select('*');
      searchedProducts.addAll(response);
    }
    searchedProducts = searchedProducts.toSet().toList();
    return searchedProducts.map<Product>((e) => Product.fromJson(e)).toList();

    // final products = await isar.products
    //     .where()
    //     .titleWordsElementStartsWith(searchQuery)
    //     .findAll();
    // print(products);
    return [];
  }

  @override
  Future<Product?> getScannedProduct({String? barCode}) async {
    final supabase = Supabase.instance.client;
    Product? searchedProduct;
    if (barCode != null) {
      final response =
          await supabase.from("products").select('*').eq('barcode', barCode);
      final searchedProducts =
          response.map((e) => Product.fromJson(e)).toList();
      if (searchedProducts.isNotEmpty) {
        searchedProduct = searchedProducts[0];
        return searchedProduct;
      } else {
        return null;
      }
    }
    // final product =
    //     await isar.products.where().barCodeEqualTo(queryWords).findFirst();

    return null;
  }

  @override
  Future<List<Brand>> getBrands() async {
    final supabase = Supabase.instance.client;
    final brands = await supabase.from('brands').select("*");

    print('Brands ${brands.map<Brand>((e) => Brand.fromJson(e)).toList()}');
    return brands.map<Brand>((e) => Brand.fromJson(e)).toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    final supabase = Supabase.instance.client;
    final categories = await supabase.from('categories').select("*");
    print(
        'Categories ${categories.map<Category>((e) => Category.fromJson(e)).toList()}');

    return categories.map<Category>((e) => Category.fromJson(e)).toList();
  }
}

Future<void> addDummyData() async {
  final isar = IsarSingleton.isar;
  final List<Map<String, dynamic>> dummyProductData = [
    {
      'id': '1',
      'name': 'Infinix Hot 11',
      'description': '6.82-inch, 64GB ROM, 4GB RAM, 5000mAh Battery',
      'category': 'Mobile Phones',
      // 'price': 149.99,
      'tax': 10.00,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'supplier': 'Infinix',
      'barcode': '1234567890',
      'images': [
        'https://fdn2.gsmarena.com/vv/bigpic/infinix-hot11.jpg',
        'https://fdn2.gsmarena.com/vv/bigpic/infinix-hot11.jpg',
      ],
      'cost_price': 120.0,
      'sale_price': 180.0,
    },
    {
      'id': '2',
      'name': 'Lenovo Legion 5',
      'description': '15.6" Gaming Laptop, Ryzen 7 5800H, 16GB RAM, 512GB SSD',
      'category': 'Laptops',
      // 'price': 999.99,
      'tax': 50.00,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'supplier': 'Lenovo',
      'barcode': '9876543210',
      'images': [
        'https://m.media-amazon.com/images/I/71fzx0pGY5L.jpg',
        'https://m.media-amazon.com/images/I/71fzx0pGY5L.jpg',
      ],
      'cost_price': 800.0,
      'sale_price': 1100.0,
    },
    {
      'id': '3',
      'name': 'Samsung Galaxy S21 Ultra',
      'description': '6.8-inch, 128GB ROM, 12GB RAM, 108MP Camera',
      'category': 'Mobile Phones',
      // 'price': 1199.99,
      'tax': 60.00,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'supplier': 'Samsung',
      'barcode': '5432109876',
      'images': [
        'https://cdn.dxomark.com/wp-content/uploads/medias/post-74840/samsunggalaxys21ultra5g.jpg',
        'https://cdn.dxomark.com/wp-content/uploads/medias/post-74840/samsunggalaxys21ultra5g.jpg',
      ],
      'cost_price': 950.0,
      'sale_price': 1400.0,
    },
    {
      'id': '4',
      'name': 'Dell XPS 13',
      'description': '13.3" Laptop, Intel Core i7, 16GB RAM, 512GB SSD',
      'category': 'Laptops',
      'sold_qty': 12.00,
      'available_qty': 56.00,
      // 'price': 1299.99,
      'tax': 65.00,
      'supplier': 'Dell',
      'barcode': '1357924680',
      'images': [
        'https://imageio.forbes.com/specials-images/imageserve/60ea00cc87d90d93f04af3d5/Dell-XPS-13-9310-OLED-/960x0.jpg?format=jpg&width=1440',
        'https://imageio.forbes.com/specials-images/imageserve/60ea00cc87d90d93f04af3d5/Dell-XPS-13-9310-OLED-/960x0.jpg?format=jpg&width=1440',
      ],
      'cost_price': 1050.0,
      'sale_price': 1500.0,
    },
    {
      'id': '5',
      'name': 'Canon EOS 5D Mark IV',
      'description': '30.4 MP Full Frame DSLR Camera Body',
      'category': 'Cameras',
      // 'price': 2499.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 125.00,
      'supplier': 'Canon',
      'barcode': '0246813579',
      'images': [
        'https://www.the-digital-picture.com/Images/Review/Canon-EOS-5D-Mark-IV.jpg',
        'https://www.the-digital-picture.com/Images/Review/Canon-EOS-5D-Mark-IV.jpg',
      ],
      'cost_price': 2000.0,
      'sale_price': 2800.0,
    },
    {
      'id': '6',
      'name': 'Sony PlayStation 5',
      'description': 'Next-Gen Gaming Console with Ultra HD Blu-ray Drive',
      'category': 'Gaming Consoles',
      // 'price': 499.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 25.00,
      'supplier': 'Sony',
      'barcode': '6789012345',
      'images': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk4WfrU7YJMwh5UA4ISKV4e1qNxr9yBeWp02DsX4JRsE5s0CtK43u7tg5DEXKfT9l89Mg&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk4WfrU7YJMwh5UA4ISKV4e1qNxr9yBeWp02DsX4JRsE5s0CtK43u7tg5DEXKfT9l89Mg&usqp=CAU',
      ],
      'cost_price': 400.0,
      'sale_price': 600.0,
    },
    {
      'id': '7',
      'name': 'Samsung 65" QLED 4K TV',
      'description': 'Samsung 65" QLED 4K Ultra HD Smart TV',
      'category': 'Electronics',
      // 'price': 899.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 45.00,
      'supplier': 'Samsung Electronics',
      'barcode': '7890123456',
      'images': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdGGv9CPExTJ0QbVveC8Nl3zSeHDRgKIcZ1aLAmBPp9zBe1ZjfTKANwAMHjICUWXwpIiI&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdGGv9CPExTJ0QbVveC8Nl3zSeHDRgKIcZ1aLAmBPp9zBe1ZjfTKANwAMHjICUWXwpIiI&usqp=CAU',
      ],
      'cost_price': 700.0,
      'sale_price': 1200.0,
    },
    {
      'id': '8',
      'name': 'Apple AirPods Pro',
      'description': 'Active Noise Cancellation for Immersive Sound',
      'category': 'Headphones',
      // 'price': 249.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 12.50,
      'supplier': 'Apple Inc.',
      'barcode': '8901234567',
      'images': [
        'https://www.apple.com/newsroom/images/tile-images/Apple_airpods-pro_new-design-102819.jpg.landing-big_2x.jpg',
        'https://www.apple.com/newsroom/images/tile-images/Apple_airpods-pro_new-design-102819.jpg.landing-big_2x.jpg',
      ],
      'cost_price': 200.0,
      'sale_price': 300.0,
    },
    {
      'id': '9',
      'name': 'LG 55" OLED 4K TV',
      'description': 'LG 55" OLED 4K Ultra HD Smart TV',
      'category': 'Electronics',
      // 'price': 1299.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 65.00,
      'supplier': 'LG Electronics',
      'barcode': '9012345678',
      'images': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfRqMEFtDMeFRRrvoxmdl1ntDxryt6Guo13ElaPfvJhNiFBMSYrIkyZ7vJTJo2gxOrLsQ&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfRqMEFtDMeFRRrvoxmdl1ntDxryt6Guo13ElaPfvJhNiFBMSYrIkyZ7vJTJo2gxOrLsQ&usqp=CAU',
      ],
      'cost_price': 1000.0,
      'sale_price': 1500.0,
    },
    {
      'id': '10',
      'name': 'Nikon D850',
      'description': '45.7 MP FX-Format DSLR Camera Body',
      'category': 'Cameras',
      // 'price': 2999.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 150.00,
      'supplier': 'Nikon Corporation',
      'barcode': '0123456789',
      'images': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZEyFT-7sBtMcbmEhSj8JtWffr8r1CXIcSIogwpQT5QAzEQla9lYwwKynn-WXMXXscbVk&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZEyFT-7sBtMcbmEhSj8JtWffr8r1CXIcSIogwpQT5QAzEQla9lYwwKynn-WXMXXscbVk&usqp=CAU',
      ],
      'cost_price': 2400.0,
      'sale_price': 3200.0,
    },
    {
      'id': '11',
      'name': 'Sony 65" 4K OLED TV',
      'description': 'Sony 65" 4K OLED Ultra HD Smart TV',
      'category': 'Electronics',
      // 'price': 1599.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 80.00,
      'supplier': 'Sony Electronics',
      'barcode': '2345678901',
      'images': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLipWUykhbzpK6RN40ZXLYqCUGZgmxNf27_XDvY9C4EynYAqRS5-l3oFVty36YaLxUm0I&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLipWUykhbzpK6RN40ZXLYqCUGZgmxNf27_XDvY9C4EynYAqRS5-l3oFVty36YaLxUm0I&usqp=CAU',
      ],
      'cost_price': 950.0,
      'sale_price': 1400.0,
    },
    {
      'id': '12',
      'name': 'Bose QuietComfort 35 II',
      'description': 'Wireless Bluetooth Headphones, Noise-Cancelling',
      'category': 'Headphones',
      // 'price': 349.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 17.50,
      'supplier': 'Bose Corporation',
      'barcode': '3456789012',
      'images': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2UwD3W48ujB5lx4yUZFsupq1flDrcVDHbbuvRQxFD_DnH9oK82Ud4NHBjsN33AZTNdz8&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2UwD3W48ujB5lx4yUZFsupq1flDrcVDHbbuvRQxFD_DnH9oK82Ud4NHBjsN33AZTNdz8&usqp=CAU',
      ],
      'cost_price': 280.0,
      'sale_price': 400.0,
    },
    {
      'id': '13',
      'name': 'HP Spectre x360',
      'description': '13.3" 2-in-1 Laptop, Intel Core i7, 16GB RAM, 1TB SSD',
      'category': 'Laptops',
      // 'price': 1399.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 70.00,
      'supplier': 'HP Inc.',
      'barcode': '4567890123',
      'images': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlstX8gPLIW2xe3httB9Fi-nRyK5K_QbemidZfczh5nnL72sL0yaWrgskDBMKDe9C9P8A&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlstX8gPLIW2xe3httB9Fi-nRyK5K_QbemidZfczh5nnL72sL0yaWrgskDBMKDe9C9P8A&usqp=CAU',
      ],
      'cost_price': 1200.0,
      'sale_price': 1600.0,
    },
    {
      'id': '14',
      'name': 'Fitbit Charge 4',
      'description': 'Fitness and Activity Tracker with Built-in GPS',
      'category': 'Wearable Technology',
      // 'price': 129.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 6.50,
      'supplier': 'Fitbit Inc.',
      'barcode': '5678901234',
      'images': [
        'https://images-na.ssl-images-amazon.com/images/I/71smqRr0pmL._AC_SL1500_.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/71smqRr0pmL._AC_SL1500_.jpg',
      ],
      'cost_price': 100.0,
      'sale_price': 150.0,
    },
    {
      'id': '15',
      'name': 'Microsoft Surface Pro 7',
      'description': '12.3" Touch-Screen, Intel Core i5, 8GB RAM, 256GB SSD',
      'category': 'Tablets',
      // 'price': 899.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 45.00,
      'supplier': 'Microsoft Corporation',
      'barcode': '6789012345',
      'images': [
        'https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6374/6374993_sd.jpg',
        'https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6374/6374993_sd.jpg',
      ],
      'cost_price': 750.0,
      'sale_price': 1100.0,
    },
    {
      'id': '16',
      'name': 'GoPro HERO9 Black',
      'description': '5K Ultra HD Action Camera',
      'category': 'Cameras',
      // 'price': 449.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 22.50,
      'supplier': 'GoPro, Inc.',
      'barcode': '7890123456',
      'images': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKKf-3iAYYIqD6eoILTNK32j2hEc3qtGVwGVdQ6-Bnrl-B-xd5ZcZjf6JO_PPtCdGq540&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKKf-3iAYYIqD6eoILTNK32j2hEc3qtGVwGVdQ6-Bnrl-B-xd5ZcZjf6JO_PPtCdGq540&usqp=CAU',
      ],
      'cost_price': 400.0,
      'sale_price': 550.0,
    },
    {
      'id': '17',
      'name': 'ASUS ROG Strix Scar 17',
      'description': '17.3" Gaming Laptop, AMD Ryzen 9, 32GB RAM, 1TB SSD',
      'category': 'Laptops',
      // 'price': 2299.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 115.00,
      'supplier': 'ASUS',
      'barcode': '8901234567',
      'images': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiLx4IAV2tC3svdLN0FU0wngl3iSgoqTG2yr6coZhmaMdlQwXAAoAwD2wdExebULQCmPc&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiLx4IAV2tC3svdLN0FU0wngl3iSgoqTG2yr6coZhmaMdlQwXAAoAwD2wdExebULQCmPc&usqp=CAU',
      ],
      'cost_price': 1900.0,
      'sale_price': 2600.0,
    },
    {
      'id': '18',
      'name': 'Amazon Echo Dot (4th Gen)',
      'description': 'Smart Speaker with Alexa',
      'category': 'Smart Home',
      // 'price': 49.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 2.50,
      'supplier': 'Amazon.com, Inc.',
      'barcode': '9012345678',
      'images': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAKn295E_AT5R1I1-82mTUcLJgOgh9sXSEiZwvOVziMc4HqkJk7NNxnVHkD2h-CIUKVsU&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAKn295E_AT5R1I1-82mTUcLJgOgh9sXSEiZwvOVziMc4HqkJk7NNxnVHkD2h-CIUKVsU&usqp=CAU',
      ],
      'cost_price': 40.0,
      'sale_price': 60.0,
    },
    {
      'id': '19',
      'name': 'Fitbit Versa 3',
      'description': 'GPS Smartwatch with Heart Rate Monitor',
      'category': 'Wearable Technology',
      // 'price': 229.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 11.50,
      'supplier': 'Fitbit Inc.',
      'barcode': '0123456789',
      'images': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRq_Rq4NepbUXFcRRa5UydrDeOLpw7yjmqq9C8q7GqCgxpf-NeVJKB59JeSboTR8VNgiOs&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRq_Rq4NepbUXFcRRa5UydrDeOLpw7yjmqq9C8q7GqCgxpf-NeVJKB59JeSboTR8VNgiOs&usqp=CAU',
      ],
      'cost_price': 180.0,
      'sale_price': 250.0,
    },
    {
      'id': '20',
      'name': 'Acer Predator Helios 300',
      'description': '15.6" Gaming Laptop, Intel i7, 16GB RAM, 512GB SSD',
      'category': 'Laptops',
      // 'price': 1199.99,
      'sold_qty': 12.00,
      'available_qty': 56.00,
      'tax': 60.00,
      'supplier': 'Acer Inc.',
      'barcode': '2345678901',
      'images': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREZYG3ys-vPazdSf4BwFsFP30dwQCc2I4M5s-bk9je44hjz8IqtGiPe5RbHmgQubtxSm8&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREZYG3ys-vPazdSf4BwFsFP30dwQCc2I4M5s-bk9je44hjz8IqtGiPe5RbHmgQubtxSm8&usqp=CAU',
      ],
      'cost_price': 950.0,
      'sale_price': 1400.0,
    },
  ];
  //
  // await isar.writeTxn(() async {
  //   for (final data in dummyProductData) {
  //     final product = Product.fromJson(data);
  //     await isar.products.put(product);
  //   }
  // });
}
