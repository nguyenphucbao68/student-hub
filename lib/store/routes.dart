import 'package:carea/screens/details_screen.dart';
import 'package:carea/screens/sign_up_choose_options_screen.dart';

import '../screens/create_new_pass_screen.dart';
import '../screens/create_pin_screen.dart';
import '../screens/flash_screen.dart';
import '../screens/forgot_pass_screen.dart';
import '../screens/forgotpass_otp.dart';
import '../screens/dashboard_screen.dart';
import '../screens/login_with_pass_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/registration_screen.dart';
import '../screens/set_finger_print_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/special_offer_screen.dart';
import '../screens/top_deals_screen.dart';
import '../screens/walkthrough_screen.dart';
import '../screens/wish_list_screen.dart';

class Routes {
  Map routes = {
    '/': (context) => HomeScreen(),
    'flash_screen_0': (context) => const FlashScreen(),
    'loading_screen': (context) => const WalkThroughScreen(),
    'login_screen': (context) => const RegistrationScreen(),
    'sign_up_screen': (context) => const SignUpScreen(),
    'login_with_pass_screen': (context) => const LoginWithPassScreen(),
    'sign_up_choose_options': (context) => const SignUpChooseOptionsScreen(),
    'profile_screen': (context) => ProfileScreen(),
    'create_pin_screen': (context) => const CreatePinScreen(),
    'set_finger_print_screen': (context) => SetFingerPrintScreen(),
    'forgot_pass_screen': (context) => const ForgotPassScreen(),
    'forgotpass_otp_screen': (context) => const ForgotPassOtp(),
    'create_new_pass_screen': (context) => const CreateNewPassScreen(),
    'notification_screen': (context) => NotificationScreen(),
    'whish_list_screen': (context) => const WishListScreen(),
    'spacial_offer_screen': (context) => const SpacialOfferScreen(),
    'top_deal_screen': (context) => const TopDealsScreen(),
    'detail_screen': (context) => DetailScreen(image: ''),
  };
}
