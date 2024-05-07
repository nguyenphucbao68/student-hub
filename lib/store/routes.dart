import 'package:carea/fragments/saved_projects_fragment.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/screens/input_profile_cv_screen.dart';
import 'package:carea/screens/input_profile_experience_screen.dart';
import 'package:carea/screens/input_profile_tech_stack_screen.dart';
import 'package:carea/screens/sign_up_choose_options_screen.dart';
import 'package:carea/screens/switch_account_screen.dart';
import 'package:flutter/material.dart';

import '../screens/create_new_pass_screen.dart';
import '../screens/flash_screen.dart';
import '../screens/forgot_pass_screen.dart';
import '../screens/login_with_pass_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/registration_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/walkthrough_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    'home': (context) => HomeScreen(),
    'flash_screen_0': (context) => const FlashScreen(),
    'loading_screen': (context) => const WalkThroughScreen(),
    'login_screen': (context) => const RegistrationScreen(),
    'sign_up_screen': (context) => const SignUpScreen(),
    'save_projects_screen': (context) => const SavedProjectsFragment(),
    'login_with_pass_screen': (context) => const LoginWithPassScreen(),
    'sign_up_choose_options': (context) => const SignUpChooseOptionsScreen(),
    'profile_screen': (context) => SwitchAccountScreen(),
    'forgot_pass_screen': (context) => const ForgotPassScreen(),
    'create_new_pass_screen': (context) => const CreateNewPassScreen(),
    // 'notification_screen': (context) => NotificationScreen(),
    'techstack_education_screen': (context) => InputProfileTechStackScreen(),
    'experience_screen': (context) => InputProfileExperience(),
    'cv_transcript_screen': (context) => InputProfileCVScreen()
  };
}
