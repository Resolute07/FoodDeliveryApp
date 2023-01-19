import 'package:food_delivery/models/product_model.dart';
import 'package:get/get.dart';

import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';

class CartController extends GetxController{
  final CartRepo cartRepo ;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  
  void addItems(ProductModel product, int quantity){
    _items.putIfAbsent( product.id!, () => CartModel(
      id: product.id,
      name: product.name,
      img: product.img,
      quantity: quantity,
      isExist: true,
      time: DateTime.now().toString(),
    ));
  }

}