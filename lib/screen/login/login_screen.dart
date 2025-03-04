import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/routes/routes_name.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../helper/button_loading_widget.dart';
import '../../helper/button_widget.dart';
import '../../helper/custom_password_textfield.dart';
import '../../helper/custom_richtext.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/login_header.dart';
import '../../helper/text_widget.dart';
import '../../provider/constant/value_provider.dart';
import '../../provider/login_signup/login_signup_provider.dart';
import '../../res/appAsset/app_assets.dart';
import '../signup/signup_screen.dart';
class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

   final _key = GlobalKey<FormState>();
   final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    final firebaseProvider = Provider.of<LoginSignupProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Stack(
         children: [
           const LoginHeader(),
           Container(
             margin: EdgeInsets.only(top: Get.width / 1.5),
             padding: const EdgeInsets.all(20.0),
             height: Get.height,
             decoration: const BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(10.0),
                 topRight: Radius.circular(10.0),
               )
             ),
             child: SingleChildScrollView(
               child: Form(
                 key: _key,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     TextWidget(text: "Login", size: 32, isBold: true,),
                     const SizedBox(height: 30.0,),
                     TextWidget(text: "Email", size: 16.0,isBold: true,),
                     const SizedBox(height: 10.0,),
                     CustomTextField(hintText: "info@example.com", controller: emailController),

                     const SizedBox(height: 20.0,),
                     TextWidget(text: "Password", size: 16.0,isBold: true,),
                     const SizedBox(height: 10.0,),
                     CustomPasswordTextField(hintText: "*********",
                       controller: passwordController, obscurePassword: _obscurePassword,),
                     const SizedBox(height: 10.0,),
                     GestureDetector(
                       onTap: (){
                         Get.toNamed(RoutesName.forgotScreen);
                       },
                       child: Align(
                           alignment: AlignmentDirectional.centerEnd,
                           child: TextWidget(text: "Forgot Password?", size: 12.0,isBold: true,)),
                     ),
                     const SizedBox(height: 50.0,),
                     Consumer<ValueProvider>(
                       builder: (context, provider, child){
                         return provider.isLoading == false  ? ButtonWidget(text: "Login", onClicked: (){
                           if(_key.currentState!.validate()){
                             _key.currentState!.save();
                             provider.setLoading(true);
                             firebaseProvider.signInWithGoogle(
                                 email: emailController.text.toString().trim(),
                                 password: passwordController.text.toString().trim(),
                                 context: context
                             );
                           }


                         }, width: Get.width, height: 50.0) :
                         ButtonLoadingWidget(
                             loadingMesasge: "logging in",
                             width: Get.width,
                             height: 50.0,
                         );
                       },
                     ),
                     const SizedBox(height: 30.0,),
                     Align(
                       alignment: AlignmentDirectional.center,
                       child: CustomRichText(press: (){
                         Get.toNamed(RoutesName.signUpScreen);
                        // Get.toNamed(RoutesName.homeScreen);
                       }, firstText: "Don't have an account?", secondText: "Sign Up"),
                     )

                   ],
                 ),
               ),
             ),
           )
         ],
        ),
      ),
    );
  }
}
