import 'dart:convert';

import 'package:carea/commons/AppTheme.dart';
import 'package:carea/commons/constants.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/model/company.dart';
import 'package:carea/model/student.dart';
import 'package:carea/model/user_info.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/screens/login_with_pass_screen.dart';
import 'package:carea/store/AppStore.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/routes.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:carea/store/socket_service.dart';
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
      // Provider<AuthProvider>(
      //   create: (_) => authStore,
      MultiProvider(
        providers: [
          Provider(create: (_) => authStore),
          Provider(
              create: (_) =>
                  ProfileOb()),
          Provider(create: (_) => SocketService()) // Thêm MyProvider vào danh sách các providers
        ],
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
  late ProfileOb profile;
  late SocketService socketService;
  int isAuthenticated = 0;
  // Student? student;
  // Company? company;

  @override
  initState() {
    super.initState();
    checkAuth();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
    profile = Provider.of<ProfileOb>(context);
    socketService = Provider.of<SocketService>(context);

    if (authStore.isLoggedIn) {
      socketService.authSocket(userToken: authStore.token!);
    }
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
        if (data["result"] != null) {
          profile.setUser(User().parse(data["result"]));
          profile.setUserCurrentRole(data["result"]["roles"][0]);
        }
        setState(() {
          isAuthenticated = 1;

          // if (data["result"]["student"] != null) {
          //   student = Student(
          //     id: data["result"]["student"]["id"],
          //     userId: data["result"]["student"]["userId"],
          //     techStackId: data["result"]["student"]["techStackId"],
          //     resume: data["result"]["student"]["resume"],
          //     transcript: data["result"]["student"]["transcript"],
          //   );
          // }

          // if (data["result"]["company"] != null) {
          //   company = Company(
          //     id: data["result"]["company"]["id"],
          //     companyName: data["result"]["company"]["companyName"],
          //     website: data["result"]["company"]["website"],
          //     size: data["result"]["company"]["size"],
          //     description: data["result"]["company"]["description"],
          //   );

          //   log("company" + company!.companyName!);
          // }
        });
      } else {
        setState(() {
          isAuthenticated = 2;
        });
      }
    }).catchError((error) {
      // authStore.setLoggedIn(false);
      log('error' + error.toString());
      setState(() {
        isAuthenticated = 2;
      });
    });
  }

  @override
  build(BuildContext context) {
    // if (student != null) {
    //   // authStore.switchAccountToStudent();
    //   if (student != null) {
    //     authStore.setStudent(student ?? Student());
    //   }

    //   if (company != null) {
    //     authStore.setCompany(company ?? Company());
    //   }
    // }
    return Observer(
      builder: (_) => MaterialApp(
        scrollBehavior: SBehavior(),
        navigatorKey: navigatorKey,
        title: APP_NAME,
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.lightTheme,
        darkTheme: AppThemeData.darkTheme,
        routes: Routes.routes,
        initialRoute: "/",
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
