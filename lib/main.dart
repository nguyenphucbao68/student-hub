import 'dart:convert';

import 'package:carea/commons/AppTheme.dart';
import 'package:carea/commons/constants.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/screens/login_with_pass_screen.dart';
import 'package:carea/store/AppStore.dart';
import 'package:carea/store/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
  late AuthProvider authStore;
  int isAuthenticated = 0;

  @override
  initState() {
    super.initState();
    checkAuth();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
  }

  Future<void> checkAuth() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token') ?? '';

    // code request api here (restful): http://localhost:4400/auth/sign-in
    await http.get(
      Uri.parse(AppConstants.BASE_URL + '/auth/me'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token,
      },
    ).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        log("Data" + data.toString());
        setState(() {
          isAuthenticated = 1;
        });
      } else {
        setState(() {
          isAuthenticated = 2;
        });
      }
    }).catchError((error) {
      // authStore.setLoggedIn(false);
      setState(() {
        isAuthenticated = 2;
      });
    });
  }

  @override
  build(BuildContext context) {
    log('test');

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
            authStore.setLoggedIn(isAuthenticated == 1);
            if (isAuthenticated == 0) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return isAuthenticated == 2 ? LoginWithPassScreen() : HomeScreen();
          },
        ),
      ),
    );
  }
}
