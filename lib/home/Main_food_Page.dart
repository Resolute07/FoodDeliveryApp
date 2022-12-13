import 'package:flutter/material.dart';
import 'package:food_delivery/colors.dart';
import 'package:food_delivery/widgets/bigtext.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(

        child: Container(
          margin: EdgeInsets.only(top: 45,bottom: 15),
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "Bangladesh"),
                      Text("city"),

                    ],
                  ),
                  Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      child: Icon(Icons.search,color: Colors.white,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),

        ),
      ),
    );
  }
}