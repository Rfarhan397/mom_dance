import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/helper/button_widget.dart';
import 'package:mom_dance/helper/subscription_card.dart';
import 'package:mom_dance/res/appAsset/app_assets.dart';
import 'package:mom_dance/screen/home/home_screen.dart';
class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.subscription_bg), // Add your image asset here
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Header Text
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Text(
                  'The Dance\nMom Life',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SubscriptionCard(
                        planName: 'Monthly',
                        price: '100',
                        planDesc: 'Billed Monthly',
                      ),
                      SubscriptionCard(
                        planName: 'Yearly',
                        price: '200',
                        planDesc: 'Billed Yearly',
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0,right: 10.0,bottom: 40.0),
                    padding: const EdgeInsets.all(20.0),
                    child: ButtonWidget(text: "Subscribe", onClicked: (){
                      Get.to(HomeScreen());
                    }, width: Get.width, height: 50.0),
                  )
                ],
              )


            ],
          ),
        ]
      ),
    );
  }
}
