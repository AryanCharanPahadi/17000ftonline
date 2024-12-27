import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:old17000ft/Controllers/adminLoginController.dart';
import 'package:old17000ft/Controllers/state_Controller.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'db.dart';
import 'home_screen.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensures bindings are initialized
  await GetStorage.init();
  await SqfliteDatabaseHelper.instance.db;

  // Dependency injection
  Get.put(StateInfoController());
  Get.put(AdminLoginController());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final userdata = GetStorage();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    // Ensuring 'isLogged' key is initialized
    GetStorage().writeIfNull('isLogged', false);

    Future.delayed(Duration.zero, () async {
      // Check login status
      await checkLogged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(),

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('in', 'IN'),
        Locale('en', 'US'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocaleLanguage in supportedLocales) {
          if (supportedLocaleLanguage.languageCode == locale?.languageCode &&
              supportedLocaleLanguage.countryCode == locale?.countryCode) {
            return supportedLocaleLanguage;
          }
        }
        return supportedLocales.first;
      },
      locale: const Locale('in'),

      debugShowCheckedModeBanner: false,

      home: AnimatedSplashScreen(
        splash: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/logo.png'),
              ),
            )),
        nextScreen: const Signin2Page(),
        backgroundColor: Colors.white,
        duration: 180,
      ),
    );
  }

  // Method to check if the user is logged in and navigate accordingly
  Future<void> checkLogged() async {
    bool isLogged = GetStorage().read('isLogged') ?? false;

    if (isLogged) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      var version = await insertVersion(uid: GetStorage().read('userId'), version: '1.3');
    }

    // Navigate to the appropriate screen based on login status
    Get.offAll(isLogged ? () => const HomeScreen() : () => const Signin2Page());
  }
}
