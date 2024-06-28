import 'package:get/get.dart';
import 'package:mom_dance/routes/routes_name.dart';
import 'package:mom_dance/screen/classSchedule/class_schedule_screen.dart';
import 'package:mom_dance/screen/compJournal/comp_journal_screen.dart';
import 'package:mom_dance/screen/compPacking/comp_packing_screen.dart';
import 'package:mom_dance/screen/compSchedule/comp_schedule_screen.dart';
import 'package:mom_dance/screen/costumeChecklist/costume_checklist_screen.dart';
import 'package:mom_dance/screen/danceAlbum/dance_album_screen.dart';
import 'package:mom_dance/screen/danceShoes/dance_shoes_screen.dart';
import 'package:mom_dance/screen/dancer/add_dancer_screen.dart';
import 'package:mom_dance/screen/dancer/dancer_screen.dart';
import 'package:mom_dance/screen/dancerDetails/add_dancer_details_screen.dart';
import 'package:mom_dance/screen/favouriteLink/favourte_links_screen.dart';
import 'package:mom_dance/screen/forgot/forgot_screen.dart';
import 'package:mom_dance/screen/home/home_screen.dart';
import 'package:mom_dance/screen/login/login_screen.dart';
import 'package:mom_dance/screen/musicLibrary/music_library_screen.dart';
import 'package:mom_dance/screen/signup/signup_screen.dart';
import 'package:mom_dance/screen/skillGoal/skiill_goal_screen.dart';
import 'package:mom_dance/screen/subscription/subscription_screen.dart';
import 'package:mom_dance/screen/travelDetails/travel_details_screen.dart';

import '../screen/measurement/measurement_screen.dart';
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
  GetPage(
    name: RoutesName.measurementScreen,
    page: () => MeasurementScreen(),
  ),
  GetPage(
    name: RoutesName.danceShoesScreen,
    page: () => DanceShoesScreen(),
  ),
  GetPage(
    name: RoutesName.skillGoalScreen,
    page: () => SkiillGoalScreen(),
  ),
  GetPage(
    name: RoutesName.costumeChecklist,
    page: () => CostumeChecklistScreen(),
  ),
  GetPage(
    name: RoutesName.classSchedule,
    page: () => ClassScheduleScreen(),
  ),
  GetPage(
    name: RoutesName.compSchedule,
    page: () => CompScheduleScreen(),
  ),

  GetPage(
    name: RoutesName.favouriteScreen,
    page: () => FavourteLinksScreen(),
  ),

  GetPage(
    name: RoutesName.compPackingScreen,
    page: () => CompPackingScreen(),
  ),

  GetPage(
    name: RoutesName.forgotScreen,
    page: () => ForgotScreen(),
  ),
  GetPage(
    name: RoutesName.travelDetailsScreen,
    page: () => TravelDetailsScreen(),
  ),

  GetPage(
    name: RoutesName.musicLibraryScreen,
    page: () => MusicLibraryScreen(),
  ),

  GetPage(
    name: RoutesName.danceAlbumScreen,
    page: () => DanceAlbumScreen(),
  ),

];
}