import 'package:flutter/material.dart';
import 'package:graduation_project/Views/Signin/Signin.dart';
import 'package:graduation_project/Views/WelcomeScreens/splash_screen.dart';
import 'package:graduation_project/core/app_colors/app_colors.dart';

import 'Views/Signin/Forget_Password.dart';
import 'Views/Signin/Reset_Password.dart';
import 'Views/Signin/SignUp.dart';
import 'Views/Signin/Verification.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
      ),
      home: ResetPasswordScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

