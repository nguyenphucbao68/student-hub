import 'package:carea/commons/AppTheme.dart';
import 'package:carea/commons/constants.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/screens/login_with_pass_screen.dart';
import 'package:carea/store/AppStore.dart';
import 'package:carea/store/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

void main() async {
  //region Entry Point
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((_) async {
    // return runApp(const MyApp());

    final authStore = AuthProvider();
    await authStore.checkLoggedIn();

    return runApp(
      Provider<AuthProvider>(
        create: (_) => authStore,
        child: MyApp(),
      ),
    );
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
    final authStore = Provider.of<AuthProvider>(context);

    return Observer(
      builder: (_) => MaterialApp(
        scrollBehavior: SBehavior(),
        navigatorKey: navigatorKey,
        title: APP_NAME,
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.lightTheme,
        darkTheme: AppThemeData.darkTheme,
        themeMode: appStore.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        // home: LoginWithPassScreen(),
        home: Observer(
          builder: (context) {
            log("token" + authStore.token.toString());
            return !authStore.isLoggedIn ? LoginWithPassScreen() : HomeScreen();
          },
        ),
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
