import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mom_dance/helper/button_widget.dart';
import 'package:mom_dance/helper/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../../helper/button_loading_widget.dart';
import '../../helper/simple_header.dart';
import '../../helper/text_widget.dart';
import '../../provider/constant/value_provider.dart';
class ForgotScreen extends StatelessWidget {
   ForgotScreen({super.key});

  var emailController = TextEditingController();

  final _key = GlobalKey<FormState>();

   final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SimpleHeader(text: 'Reset Password',),
                SizedBox(height: 50,),
                TextWidget(text: 'Enter your email to reset your passwordEnter your email to reset your password',size: 14.0,),
                SizedBox(height: 30,),
                CustomTextField(hintText: "Enter email", controller: emailController),
                SizedBox(height: 50,),

                ButtonWidget(text: "Login", onClicked: (){
                  if(_key.currentState!.validate()){
                    _key.currentState!.save();

                   _sendPasswordResetEmail(context: context, email: emailController.text.toString().trim());
                  }


                }, width: Get.width, height: 50.0)
              ],
            ),
          ),
        ),
      ),
    );
  }

   void _sendPasswordResetEmail({required BuildContext context,required String email}) async {
     try {
       await _auth.sendPasswordResetEmail(email: email);
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Password reset link sent! Check your email.')),
       );
     } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Failed to send password reset link.')),
       );
     }
   }
}
