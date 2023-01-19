import 'package:food_delivery/pages/home/Main_food_Page.dart';
import 'package:food_delivery/pages/home/food/recommended_food_details.dart';
import 'package:get/get.dart';

import '../pages/home/food/popular_food_details.dart';
class RouteHelper{

  static const String initial = '/';
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static  String getPopularFood(int pageId)=> '$popularFood?pageId=$pageId';
  static String getInitial() => '$initial';
  static String getRecommendedFood(int pageId)=> "$recommendedFood?pageId=$pageId" ;


  static List<GetPage> route = [
    GetPage(name: initial, page: ()=> MainFoodPage()),

    GetPage(name: popularFood, page: () {
      var pageId = Get.parameters['pageId'];
      return PopularFoodDetail( pageId: int.parse(pageId!));
    },

        transition: Transition.fadeIn
        ),

    GetPage(name: recommendedFood, page: (){
      var pageId = Get.parameters['pageId'];
      return RecommendedFoodDetails(pageId: int.parse(pageId!));
      },
        transition: Transition.fadeIn
    ),

  ];
}