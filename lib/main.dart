import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/provider/classSchedulle/class_schedule_provider.dart';
import 'package:mom_dance/provider/constant/password_visible_provider.dart';
import 'package:mom_dance/provider/constant/value_provider.dart';
import 'package:mom_dance/provider/countdown/countdown_provider.dart';
import 'package:mom_dance/provider/dancer/dancer_provider.dart';
import 'package:mom_dance/provider/image/image_provider.dart';
import 'package:mom_dance/provider/login_signup/login_signup_provider.dart';
import 'package:mom_dance/provider/measurements/measurement_provider.dart';
import 'package:mom_dance/provider/user/user_provider.dart';
import 'package:mom_dance/routes/routes.dart';
import 'package:mom_dance/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PasswordVisibleProvider()),
        ChangeNotifierProvider(create: (_) => ValueProvider()),
        ChangeNotifierProvider(create: (_) => LoginSignupProvider()),
        ChangeNotifierProvider(create: (_) => CountdownProvider()),
        ChangeNotifierProvider(create: (_) => DancerProvider()),
        ChangeNotifierProvider(create: (_) => ImagePickProvider()),
        ChangeNotifierProvider(create: (_) => MeasurementProvider()),
        ChangeNotifierProvider(create: (_) => ClassScheduleProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mom Dance',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.splashScreen,
        getPages: Routes.routes,
      ),
    );
  }
}

