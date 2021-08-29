import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app/src/configs/app_colors.dart';
import 'package:jobs_app/src/pages/home.dart';
import 'package:jobs_app/src/pages/sign_in.dart';

// App Container - Single in most cases
// Page Container - Multiple in most cases

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp = App container
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (childContext, snap) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: snap.connectionState == ConnectionState.waiting ||
                FirebaseAuth.instance.currentUser == null
            ? SignIn()
            : Home(),
        themeMode: ThemeMode.dark,
        theme: ThemeData(fontFamily: "Poppins"),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.primaryColor,
        ),
      ),
    );
  }
}
