import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo ;
  PopularProductController({required this.popularProductRepo});
  List<dynamic>  get popularProductList => _popularProductList;
  List<dynamic> _popularProductList = [];
  bool _isLoaded = false ;
  bool get isLoaded  => _isLoaded ;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems+ _quantity ;
  late CartController _cart ;
  Future<void> getPopularProductList() async{
    Response response = await  popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded =true ;
      update(); //kind of set state
    }else{
      print('no data');
    }
  }
  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity+1);
    } else {
      _quantity =checkQuantity(_quantity -1);
    }
    update();
  }
  int checkQuantity(int quantity){
    if(quantity<0){
      Get.snackbar("item Count ", "You can't reduce more",
      backgroundColor: AppColors.mainColor,
        colorText: Colors.white
      );
      return 0 ;
    }
    else if(quantity > 20){
      Get.snackbar("item Count ", "You can't increase  more",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white
      );
      return 20 ;
    }
    else {
      return quantity;
  }}

  void initProduct(CartController cart){
    _quantity = 0 ;
    _inCartItems= 0;
    _cart = cart ;
    //if exists
    //get from storage _inCartItems
  }

  void addItem(ProductModel product){
    _cart.addItems(product, _quantity);
  }

}