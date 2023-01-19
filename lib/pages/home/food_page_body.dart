import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/constants/appConstants.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/pages/home/food/popular_food_details.dart';
import 'package:food_delivery/routes/route_helper.dart';

import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';

import 'package:food_delivery/widgets/icons_and%20_text_widget.dart';
import 'package:get/get.dart';

import '../../widgets/bigtext.dart';
import '../../utils/colors.dart';
import '../../widgets/smalltext.dart';




class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewController;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder: (popularproducts){
          return popularproducts.isLoaded?  Container(
            //color: Colors.blue,
            height: Dimensions.pageView,
            child: PageView.builder(
                controller: pageController,
                itemCount: popularproducts.popularProductList.length,
                itemBuilder: (context, position) {
                  return _buildPageItem(position, popularproducts.popularProductList[position]);
                }),
          ): CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        //dots
        GetBuilder<PopularProductController>(builder: (popularproduct){
          return DotsIndicator(
            dotsCount: popularproduct.popularProductList.length <= 0 ? 1: popularproduct.popularProductList.length  ,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //popular text
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing"),
              )
            ],
          ),
        ),
        //list of food and images
       GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
         return recommendedProduct.isLoaded?ListView.builder(
             physics: NeverScrollableScrollPhysics(),
             shrinkWrap: true,
             itemCount: recommendedProduct.recommendedProductList.length,
             itemBuilder: (context, index) {
               return GestureDetector(
                 onTap: (){
                   Get.toNamed(RouteHelper.getRecommendedFood(index));
                 },
                 child: Container(
                     margin: EdgeInsets.only(
                       left: Dimensions.width20,
                       right: Dimensions.width20,
                       bottom: Dimensions.height10,
                     ),
                     child: Row(
                       children: [
                         // image section
                         Container(
                           width: Dimensions.listViewImgSize,
                           height: Dimensions.listViewImgSize,
                           decoration: BoxDecoration(
                             borderRadius:
                             BorderRadius.circular(Dimensions.radius20),
                             color: Colors.white30,
                             image: DecorationImage(
                               fit: BoxFit.cover,
                               image: NetworkImage(
                                   AppConstants.BASE_URL + AppConstants.UPLOAD_URL+ recommendedProduct.recommendedProductList[index].img!),
                             ),
                           ),
                         ),
                         // text container
                         Expanded(
                           child: Container(
                             height: Dimensions.listViewTextConstSize,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.only(
                                   bottomRight:
                                   Radius.circular(Dimensions.radius20),
                                   topRight:
                                   Radius.circular(Dimensions.radius20),
                                 ),
                                 color: Colors.white),
                             child: Padding(
                               padding:
                               EdgeInsets.only(left: Dimensions.width10),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   SizedBox(
                                     height: Dimensions.height10,
                                   ),
                                   BigText(
                                       text: recommendedProduct.recommendedProductList[index].name!),
                                   SizedBox(
                                     height: Dimensions.height10,
                                   ),
                                   SmallText(text: "hello"),
                                   SizedBox(
                                     height: Dimensions.height10,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       IconsAndTextWidget(
                                         text: "Normal",
                                         icon: Icons.circle_sharp,
                                         iconColor: AppColors.iconColor1,
                                       ),
                                       IconsAndTextWidget(
                                         text: "1.7 Km",
                                         icon: Icons.location_on,
                                         iconColor: AppColors.mainColor,
                                       ),
                                       IconsAndTextWidget(
                                         text: "32 Min",
                                         icon: Icons.access_time_rounded,
                                         iconColor: AppColors.iconColor2,
                                       )
                                     ],
                                   )
                                 ],
                               ),
                             ),
                           ),
                         )
                       ],
                     )),
               );
             }) : CircularProgressIndicator(
           color: AppColors.mainColor,
         );
       }),

      ],
    );
  }

  Widget _buildPageItem(int index , ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);

      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);

      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(children: [
        GestureDetector(
          onTap: (){
            Get.toNamed(RouteHelper.getPopularFood(index));
          },
          child: Container(
            height: Dimensions.pageViewController,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
              image: DecorationImage(
                image: NetworkImage(
                    AppConstants.BASE_URL + AppConstants.UPLOAD_URL+ popularProduct.img!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.pageViewTextController,
            margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  )
                ]),
            child: Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  left: Dimensions.height15,
                  right: Dimensions.height15),
              child: AppColumn(text: popularProduct.name!,),
            ),
          ),
        )
      ]),
    );
  }
}
