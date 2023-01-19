
import 'package:food_delivery/constants/appConstants.dart';
import 'package:food_delivery/data/api/apiClient.dart';
import 'package:get/get.dart';
class PopularProductRepo extends GetxService{
  final ApiClient apiClient ;
PopularProductRepo({required this.apiClient});
  Future<Response> getPopularProductList() async{
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URL);

  }
}