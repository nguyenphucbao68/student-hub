import 'package:carea/commons/AppTheme.dart';
import 'package:carea/commons/constants.dart';
import 'package:carea/components/project_filter_component.dart';
import 'package:carea/fragments/dashboard_fragment.dart';
import 'package:carea/fragments/inbox_fragment.dart';
import 'package:carea/fragments/orders_fragment.dart';
import 'package:carea/fragments/projects_fragment.dart';
import 'package:carea/fragments/saved_projects_fragment.dart';
import 'package:carea/screens/chat_screen.dart';
import 'package:carea/screens/create_new_pass_screen.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/screens/details_screen.dart';
import 'package:carea/screens/flash_screen.dart';
import 'package:carea/screens/forgot_pass_screen.dart';
import 'package:carea/screens/payment_screen.dart';
import 'package:carea/screens/profile_input_nhap_screen.dart';
import 'package:carea/screens/profile_screen.dart';
import 'package:carea/screens/project_search_screen.dart';
import 'package:carea/screens/registration_screen.dart';
import 'package:carea/screens/set_finger_print_screen.dart';
import 'package:carea/screens/signup_screen.dart';
import 'package:carea/screens/special_offer_screen.dart';
import 'package:carea/store/AppStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/screens/flash_screen.dart';

import 'package:carea/screens/switch_account_screen.dart';
import 'package:carea/screens/profile_input_ahaa_screen.dart';

import 'package:carea/screens/profile_input_nhap_screen.dart';
import 'package:carea/screens/project_details_screen.dart';

void main() async {
  //region Entry Point
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((_) {
    return runApp(const MyApp());
  });
}

AppStore appStore = AppStore();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        scrollBehavior: SBehavior(),
        navigatorKey: navigatorKey,
        title: APP_NAME,
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.lightTheme,
        darkTheme: AppThemeData.darkTheme,
        themeMode: appStore.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        home: FlashScreen(),
        // home: PaymentScreen(),
        // home: ProfileInputNhapScreen(),
        // home: SavedProjectsFragment(),
        // home: ProjectSearchScreen(),
        // home: DashBoardFragment(),

        // home: InboxFragment(),
      ),
    );
  }
}
