import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';

abstract class ProductListDataSource {
  Future<List<Product>> getProductsList();
}

class ProductListDataSourceImpl implements ProductListDataSource {
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
        'price': 149.99,
        'tax': 10.00,
        'supplier': 'Infinix',
        'barcode': '1234567890',
        'images': [
          'https://fdn2.gsmarena.com/vv/bigpic/infinix-hot11.jpg',
          'https://fdn2.gsmarena.com/vv/bigpic/infinix-hot11.jpg',
        ],
      },
      {
        'id': '2',
        'name': 'Lenovo Legion 5',
        'description':
            '15.6" Gaming Laptop, Ryzen 7 5800H, 16GB RAM, 512GB SSD',
        'category': 'Laptops',
        'price': 999.99,
        'tax': 50.00,
        'supplier': 'Lenovo',
        'barcode': '9876543210',
        'images': [
          'https://m.media-amazon.com/images/I/71fzx0pGY5L.jpg',
          'https://m.media-amazon.com/images/I/71fzx0pGY5L.jpg',
        ],
      },
      {
        'id': '3',
        'name': 'Samsung Galaxy S21 Ultra',
        'description': '6.8-inch, 128GB ROM, 12GB RAM, 108MP Camera',
        'category': 'Mobile Phones',
        'price': 1199.99,
        'tax': 60.00,
        'supplier': 'Samsung',
        'barcode': '5432109876',
        'images': [
          'https://cdn.dxomark.com/wp-content/uploads/medias/post-74840/samsunggalaxys21ultra5g.jpg',
          'https://cdn.dxomark.com/wp-content/uploads/medias/post-74840/samsunggalaxys21ultra5g.jpg',
        ],
      },
      {
        'id': '4',
        'name': 'Dell XPS 13',
        'description': '13.3" Laptop, Intel Core i7, 16GB RAM, 512GB SSD',
        'category': 'Laptops',
        'price': 1299.99,
        'tax': 65.00,
        'supplier': 'Dell',
        'barcode': '1357924680',
        'images': [
          'https://imageio.forbes.com/specials-images/imageserve/60ea00cc87d90d93f04af3d5/Dell-XPS-13-9310-OLED-/960x0.jpg?format=jpg&width=1440',
          'https://imageio.forbes.com/specials-images/imageserve/60ea00cc87d90d93f04af3d5/Dell-XPS-13-9310-OLED-/960x0.jpg?format=jpg&width=1440',
        ],
      },
      {
        'id': '5',
        'name': 'Canon EOS 5D Mark IV',
        'description': '30.4 MP Full Frame DSLR Camera Body',
        'category': 'Cameras',
        'price': 2499.99,
        'tax': 125.00,
        'supplier': 'Canon',
        'barcode': '0246813579',
        'images': [
          'https://www.the-digital-picture.com/Images/Review/Canon-EOS-5D-Mark-IV.jpg',
          'https://www.the-digital-picture.com/Images/Review/Canon-EOS-5D-Mark-IV.jpg',
        ],
      },
      {
        'id': '6',
        'name': 'Sony PlayStation 5',
        'description': 'Next-Gen Gaming Console with Ultra HD Blu-ray Drive',
        'category': 'Gaming Consoles',
        'price': 499.99,
        'tax': 25.00,
        'supplier': 'Sony',
        'barcode': '6789012345',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk4WfrU7YJMwh5UA4ISKV4e1qNxr9yBeWp02DsX4JRsE5s0CtK43u7tg5DEXKfT9l89Mg&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk4WfrU7YJMwh5UA4ISKV4e1qNxr9yBeWp02DsX4JRsE5s0CtK43u7tg5DEXKfT9l89Mg&usqp=CAU',
        ],
      },
      {
        'id': '7',
        'name': 'Samsung 65" QLED 4K TV',
        'description': 'Samsung 65" QLED 4K Ultra HD Smart TV',
        'category': 'Electronics',
        'price': 899.99,
        'tax': 45.00,
        'supplier': 'Samsung Electronics',
        'barcode': '7890123456',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdGGv9CPExTJ0QbVveC8Nl3zSeHDRgKIcZ1aLAmBPp9zBe1ZjfTKANwAMHjICUWXwpIiI&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdGGv9CPExTJ0QbVveC8Nl3zSeHDRgKIcZ1aLAmBPp9zBe1ZjfTKANwAMHjICUWXwpIiI&usqp=CAU',
        ],
      },
      {
        'id': '8',
        'name': 'Apple AirPods Pro',
        'description': 'Active Noise Cancellation for Immersive Sound',
        'category': 'Headphones',
        'price': 249.99,
        'tax': 12.50,
        'supplier': 'Apple Inc.',
        'barcode': '8901234567',
        'images': [
          'https://www.apple.com/newsroom/images/tile-images/Apple_airpods-pro_new-design-102819.jpg.landing-big_2x.jpg',
          'https://www.apple.com/newsroom/images/tile-images/Apple_airpods-pro_new-design-102819.jpg.landing-big_2x.jpg',
        ],
      },
      {
        'id': '9',
        'name': 'LG 55" OLED 4K TV',
        'description': 'LG 55" OLED 4K Ultra HD Smart TV',
        'category': 'Electronics',
        'price': 1299.99,
        'tax': 65.00,
        'supplier': 'LG Electronics',
        'barcode': '9012345678',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfRqMEFtDMeFRRrvoxmdl1ntDxryt6Guo13ElaPfvJhNiFBMSYrIkyZ7vJTJo2gxOrLsQ&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfRqMEFtDMeFRRrvoxmdl1ntDxryt6Guo13ElaPfvJhNiFBMSYrIkyZ7vJTJo2gxOrLsQ&usqp=CAU',
        ],
      },
      {
        'id': '10',
        'name': 'Nikon D850',
        'description': '45.7 MP FX-Format DSLR Camera Body',
        'category': 'Cameras',
        'price': 2999.99,
        'tax': 150.00,
        'supplier': 'Nikon Corporation',
        'barcode': '0123456789',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZEyFT-7sBtMcbmEhSj8JtWffr8r1CXIcSIogwpQT5QAzEQla9lYwwKynn-WXMXXscbVk&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZEyFT-7sBtMcbmEhSj8JtWffr8r1CXIcSIogwpQT5QAzEQla9lYwwKynn-WXMXXscbVk&usqp=CAU',
        ],
      },
      {
        'id': '11',
        'name': 'Sony 65" 4K OLED TV',
        'description': 'Sony 65" 4K OLED Ultra HD Smart TV',
        'category': 'Electronics',
        'price': 1599.99,
        'tax': 80.00,
        'supplier': 'Sony Electronics',
        'barcode': '2345678901',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLipWUykhbzpK6RN40ZXLYqCUGZgmxNf27_XDvY9C4EynYAqRS5-l3oFVty36YaLxUm0I&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLipWUykhbzpK6RN40ZXLYqCUGZgmxNf27_XDvY9C4EynYAqRS5-l3oFVty36YaLxUm0I&usqp=CAU',
        ],
      },
      {
        'id': '12',
        'name': 'Bose QuietComfort 35 II',
        'description': 'Wireless Noise-Canceling Headphones',
        'category': 'Headphones',
        'price': 299.99,
        'tax': 15.00,
        'supplier': 'Bose Corporation',
        'barcode': '3456789012',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2UwD3W48ujB5lx4yUZFsupq1flDrcVDHbbuvRQxFD_DnH9oK82Ud4NHBjsN33AZTNdz8&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2UwD3W48ujB5lx4yUZFsupq1flDrcVDHbbuvRQxFD_DnH9oK82Ud4NHBjsN33AZTNdz8&usqp=CAU',
        ],
      },
      {
        'id': '13',
        'name': 'Sony Alpha a7 III',
        'description': '24.2 MP Full-Frame Mirrorless Camera',
        'category': 'Cameras',
        'price': 1999.99,
        'tax': 100.00,
        'supplier': 'Sony Electronics',
        'barcode': '4567890123',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlstX8gPLIW2xe3httB9Fi-nRyK5K_QbemidZfczh5nnL72sL0yaWrgskDBMKDe9C9P8A&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlstX8gPLIW2xe3httB9Fi-nRyK5K_QbemidZfczh5nnL72sL0yaWrgskDBMKDe9C9P8A&usqp=CAU',
        ],
      },
      {
        'id': '14',
        'name': 'HP Pavilion 15',
        'description': '15.6" Laptop, Intel Core i5, 8GB RAM, 256GB SSD',
        'category': 'Laptops',
        'price': 699.99,
        'tax': 35.00,
        'supplier': 'HP Inc.',
        'barcode': '5678901234',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnz-hOqzFRztVRYn2CclMA3pcZvExXP2pP5C0MBhpr9m5Bwhp9qrfSiaA9iL1vIEOLRu4&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnz-hOqzFRztVRYn2CclMA3pcZvExXP2pP5C0MBhpr9m5Bwhp9qrfSiaA9iL1vIEOLRu4&usqp=CAU',
        ],
      },
      {
        'id': '15',
        'name': 'Google Pixel 6 Pro',
        'description': '6.7-inch, 128GB ROM, 12GB RAM, 50MP Camera',
        'category': 'Mobile Phones',
        'price': 899.99,
        'tax': 45.00,
        'supplier': 'Google LLC',
        'barcode': '6789012345',
        'images': [
          'https://cdn.dxomark.com/wp-content/uploads/medias/post-96650/Google-Pixel-6-Pro-featured-image-packshot-review-1024x691.jpg',
          'https://cdn.dxomark.com/wp-content/uploads/medias/post-96650/Google-Pixel-6-Pro-featured-image-packshot-review-1024x691.jpg',
        ],
      },
      {
        'id': '16',
        'name': 'Sony WH-1000XM4',
        'description': 'Wireless Noise-Canceling Over-Ear Headphones',
        'category': 'Headphones',
        'price': 349.99,
        'tax': 17.50,
        'supplier': 'Sony Electronics',
        'barcode': '7890123456',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKKf-3iAYYIqD6eoILTNK32j2hEc3qtGVwGVdQ6-Bnrl-B-xd5ZcZjf6JO_PPtCdGq540&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKKf-3iAYYIqD6eoILTNK32j2hEc3qtGVwGVdQ6-Bnrl-B-xd5ZcZjf6JO_PPtCdGq540&usqp=CAU',
        ],
      },
      {
        'id': '17',
        'name': 'Apple iPad Air 4',
        'description': '10.9-inch, 256GB, Wi-Fi, Space Gray',
        'category': 'Tablets',
        'price': 599.99,
        'tax': 30.00,
        'supplier': 'Apple Inc.',
        'barcode': '9012345678',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiLx4IAV2tC3svdLN0FU0wngl3iSgoqTG2yr6coZhmaMdlQwXAAoAwD2wdExebULQCmPc&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiLx4IAV2tC3svdLN0FU0wngl3iSgoqTG2yr6coZhmaMdlQwXAAoAwD2wdExebULQCmPc&usqp=CAU',
        ],
      },
      {
        'id': '18',
        'name': 'Microsoft Surface Laptop 4',
        'description': '13.5-inch, Ryzen 7, 16GB RAM, 512GB SSD',
        'category': 'Laptops',
        'price': 1299.99,
        'tax': 65.00,
        'supplier': 'Microsoft Corporation',
        'barcode': '0123456789',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAKn295E_AT5R1I1-82mTUcLJgOgh9sXSEiZwvOVziMc4HqkJk7NNxnVHkD2h-CIUKVsU&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAKn295E_AT5R1I1-82mTUcLJgOgh9sXSEiZwvOVziMc4HqkJk7NNxnVHkD2h-CIUKVsU&usqp=CAU',
        ],
      },
      {
        'id': '19',
        'name': 'Sony Xperia 1 III',
        'description': '6.5-inch, 256GB ROM, 12GB RAM, 12MP Camera',
        'category': 'Mobile Phones',
        'price': 1199.99,
        'tax': 60.00,
        'supplier': 'Sony',
        'barcode': '2345678901',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRq_Rq4NepbUXFcRRa5UydrDeOLpw7yjmqq9C8q7GqCgxpf-NeVJKB59JeSboTR8VNgiOs&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRq_Rq4NepbUXFcRRa5UydrDeOLpw7yjmqq9C8q7GqCgxpf-NeVJKB59JeSboTR8VNgiOs&usqp=CAU',
        ],
      },
      {
        'id': '20',
        'name': 'Samsung 34" Curved QLED Monitor',
        'description': 'Ultra-Wide Curved 1440p Monitor',
        'category': 'Monitors',
        'price': 499.99,
        'tax': 25.00,
        'supplier': 'Samsung Electronics',
        'barcode': '3456789012',
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREZYG3ys-vPazdSf4BwFsFP30dwQCc2I4M5s-bk9je44hjz8IqtGiPe5RbHmgQubtxSm8&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREZYG3ys-vPazdSf4BwFsFP30dwQCc2I4M5s-bk9je44hjz8IqtGiPe5RbHmgQubtxSm8&usqp=CAU',
        ],
      },
    ];

    final List<Product> dummyProducts =
        dummyProductData.map((data) => Product.fromJson(data)).toList();

    return dummyProducts;
  }
}
