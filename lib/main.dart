import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';

import 'package:food_delivery/pages/home/Main_food_Page.dart';
import 'package:food_delivery/pages/home/food/popular_food_details.dart';
import 'package:food_delivery/pages/home/food/recommended_food_details.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DBFood',


      home: MainFoodPage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.route,
    );
  }
}

