import 'package:isar/isar.dart';
import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/init_isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AddUpdateProductSource {
  Future<Product> addProduct(Product newProduct);
  Future<Product> updateProduct(Product updatedProduct);
  Future<Product?> getDetails(int id);
  Future<bool> deleteProduct(int id);
}

class AddUpdateProductSourceImpl implements AddUpdateProductSource {
  @override
  Future<Product> addProduct(Product newProduct) async {
    try{
      final supabase = Supabase.instance.client;

      final updatedProduct = await supabase.from('products').insert([
        {
          "name": newProduct.name,
          "description": newProduct.description,
          "cost_price": newProduct.costPrice,
          "sale_price": newProduct.salePrice,
          "tax": newProduct.tax,
          "available_qty": newProduct.availableQty,
          "sold_qty": newProduct.soldQty,
          "category": newProduct.category,
          "supplier": newProduct.supplier,
          "barcode": newProduct.barcode,
          "product_image": newProduct.image,
          "image_reference":newProduct.imageReference
        },
      ]).select();
      print("Add product list${updatedProduct}");
      return Product.fromJson(updatedProduct[0]);

    }catch(error){
      print("Error adding product:$error}");
      return Future.error(error);

    }

    // throw UnimplementedError();
  }

  @override
  Future<Product> updateProduct(Product updatedProduct) async {
    // TODO: implement updateProduct
    try{
      final supabase = Supabase.instance.client;

      final productList = await supabase
          .from('products')
          .update({
        "name": updatedProduct.name,
        "description": updatedProduct.description,
        "cost_price": updatedProduct.costPrice,
        "sale_price": updatedProduct.salePrice,
        "tax": updatedProduct.tax,
        "available_qty": updatedProduct.availableQty,
        "sold_qty": updatedProduct.soldQty,
        "category": updatedProduct.category,
        "supplier": updatedProduct.supplier,
        "barcode": updatedProduct.barcode,
        "product_image": updatedProduct.image,
      })
          .eq('id', updatedProduct.id!) // Assuming 'product_id' is your primary key
          .select();
      print("Update product list${productList}");
      return Product.fromJson(productList[0]);

    }catch(error){
      print("Error updating product:$error}");
      return Future.error(error);

    }

    // throw UnimplementedError();
  }

  @override
  Future<Product?> getDetails(int id) async {
    final isar = IsarSingleton.isar;
    // final product =
    //     await isar.products.where().idEqualTo(id).findFirst();
    return null;
  }

  @override
  Future<bool> deleteProduct(int id)async {
 try{
   final supabase = Supabase.instance.client;

   final status = await supabase
       .from('products')
       .delete()
       .eq('id', id);
   return true;
 }
 catch(error){
   print("Error deleting product:$error}");
   return Future.error(error);
 }


  }
}
