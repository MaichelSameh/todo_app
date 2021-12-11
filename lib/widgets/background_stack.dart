import 'package:flutter/material.dart';

import '../config/path.dart';

class BackgroundStack extends StatelessWidget {
  const BackgroundStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.31,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              MyPath.images_path + "dark_wave.png",
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Opacity(
          opacity: 0.31,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              MyPath.images_path + "colored_wave.png",
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Opacity(
          opacity: 0.03,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(24, 23, 47, 1),
                  Color.fromRGBO(3, 0, 145, 1),
                ],
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.9,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 255, 255, 1),
                  Color.fromRGBO(202, 235, 254, 0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
