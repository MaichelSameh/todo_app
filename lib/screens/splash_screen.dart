import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/palette.dart';
import '../config/path.dart';
import 'todo_list_screen.dart';

class SplashScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "splash_screen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(TodoListScreen.route_name);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: MyPalette.logo_gradient,
          ),
        ),
        child: SvgPicture.asset(
          MyPath.icons_path + "logo_icon" + MyPath.icons_extension,
          color: Colors.white,
        ),
      ),
    );
  }
}
