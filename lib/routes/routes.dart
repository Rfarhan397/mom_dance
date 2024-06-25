import 'package:get/get.dart';
import 'package:mom_dance/routes/routes_name.dart';
import 'package:mom_dance/screen/compJournal/comp_journal_screen.dart';
import 'package:mom_dance/screen/dancer/add_dancer_screen.dart';
import 'package:mom_dance/screen/dancer/dancer_screen.dart';
import 'package:mom_dance/screen/dancerDetails/add_dancer_details_screen.dart';
import 'package:mom_dance/screen/home/home_screen.dart';
import 'package:mom_dance/screen/login/login_screen.dart';
import 'package:mom_dance/screen/signup/signup_screen.dart';
import 'package:mom_dance/screen/subscription/subscription_screen.dart';

import '../screen/splalsh/splash_screen.dart';

class Routes{
static final routes = [
  GetPage(
    name: RoutesName.splashScreen,
    page: () => SplashScreen(),
  ),
  GetPage(
    name: RoutesName.loginScreen,
    page: () => LoginScreen(),
  ),
  GetPage(
    name: RoutesName.signUpScreen,
    page: () => SignupScreen(),
  ),
  GetPage(
    name: RoutesName.homeScreen,
    page: () => HomeScreen(),
  ),
  GetPage(
    name: RoutesName.subscriptionScreen,
    page: () => SubscriptionScreen(),
  ),
  GetPage(
    name: RoutesName.dancerScreen,
    page: () => DancerScreen(),
  ),
  GetPage(
    name: RoutesName.addDancerScreen,
    page: () => AddDancerScreen(),
  ),
  GetPage(
    name: RoutesName.addDancerDetailsScreen,
    page: () => AddDancerDetailsScreen(),
  ),
  GetPage(
    name: RoutesName.compJournalScreen,
    page: () => CompJournalScreen(),
  ),

];
}