import 'package:get/get.dart';
import 'package:instagram_clone/Modules/screens/DashBoardManagement/home_screen.dart';
import 'package:instagram_clone/Modules/screens/DashBoardManagement/storyUploadScreen.dart';
import 'package:instagram_clone/Modules/screens/PostManagement/post_screen.dart';
import 'package:instagram_clone/Modules/screens/ProfileManagement/profile.dart';
import 'package:instagram_clone/Modules/screens/ReelScrollManagement/reel_scroll_screen.dart';
import 'package:instagram_clone/Modules/screens/DashBoardManagement/search_Screen.dart';
import 'package:instagram_clone/Modules/screens/signup_screen.dart';
import '../Modules/screens/ChatManagement/ai_chat_screen.dart';
import '../Modules/screens/ChatManagement/main_chat_screen.dart';
import '../Modules/screens/DashBoardManagement/notification_Screen.dart';
import '../Modules/screens/ProfileManagement/menu_screen.dart';
import '../Modules/screens/common_screen.dart';
import '../Modules/screens/login_screen.dart';
import '../Modules/screens/splash_screen.dart';


class RoutesClass {

  static String splash = '/splash';
  static String commonScreen = '/commonScreen';
  static String login = '/login';
  static String homeScreen = '/homeScreen';
  static String scrollScreen = '/scrollScreen';
  static String postScreen = '/postScreen';
  static String profile = '/profile';
  static String searchScreen = '/searchScreen';
  static String menuScreen = '/menuScreen';
  static String notificationscreen = '/notificationScreen';
  static String signup = '/signup';
  static String uploadstoryscreen = '/uploadstoryscreen';
  static String aiChatScreen = '/aiChatScreen';

  static String friendsChatScreen = '/friendsChatScreen';

  static String gotoFriendsChatScreen() => friendsChatScreen;

  static String gotoAiChatScreen() => aiChatScreen;
  static String gotoSplash() => splash;
  static String gotoNotificationscreen() => notificationscreen;
  static String gotoMenuScreen() => menuScreen;
  static String gotoLoginScreen() => login;
  static String gotoSignupScreen() => signup;
  static String gotoCommonScreen()=>commonScreen;
  static String gotoHomeScreen()=>commonScreen;
  static String gotoScrollScreen()=>scrollScreen;
  static String gotoPostScreen()=>postScreen;
  static String gotoProfileScreen()=>profile;
  static String gotoSearchScreen()=>searchScreen;
  static String gotoUploadStoryScreen()=>uploadstoryscreen;

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: uploadstoryscreen,
      page: () => StoryUploadScreen(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: commonScreen,
      page: () => CommonScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: notificationscreen,
      page: () => NotificationScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: signup,
      page: () => SignupScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    )
    ,
    GetPage(
      name: login,
      page: () => LoginScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: profile,
      page: () => Profile(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: menuScreen,
      page: () => MenuScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: postScreen,
      page: () => PostScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: scrollScreen,
      page: () => ReelScrollScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: searchScreen,
      page: () => SearchScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(name: RoutesClass.aiChatScreen, page: () => AiChatScreen()),

    GetPage(name: RoutesClass.friendsChatScreen, page: () => FriendsChatListScreen()),



  ];
}