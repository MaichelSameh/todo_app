import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/path.dart';
import '../models/size.dart';

enum CustomIconType {
  shopping,
  sports,
  visits,
  parties,
  workout,
  others,
  add,
  calendar,
  select,
  cancel,
  done,
}

enum CustomIconStatus { selected, done, none }

class CustomIcon extends StatelessWidget {
  CustomIcon({Key? key, required this.iconType}) : super(key: key) {
    switch (iconType) {
      case CustomIconType.shopping:
        gradient = const [
          Color.fromRGBO(254, 30, 154, 1),
          Color.fromRGBO(254, 166, 76, 1),
        ];
        radius = 14;
        iconName = "shopping_icon";
        break;
      case CustomIconType.sports:
        gradient = const [
          Color.fromRGBO(37, 77, 222, 1),
          Color.fromRGBO(254, 30, 154, 1),
        ];
        radius = 14;
        iconName = "sport_icon";
        break;
      case CustomIconType.visits:
        gradient = const [
          Color.fromRGBO(24, 23, 67, 1),
          Color.fromRGBO(37, 77, 222, 1),
        ];
        radius = 14;
        iconName = "visit_icon";
        break;
      case CustomIconType.parties:
        gradient = const [
          Color.fromRGBO(0, 255, 255, 1),
          Color.fromRGBO(37, 77, 222, 1),
        ];
        radius = 14;
        iconName = "party_icon";
        break;
      case CustomIconType.workout:
        gradient = const [
          Color.fromRGBO(37, 77, 222, 1),
          Color.fromRGBO(254, 30, 154, 1),
        ];
        radius = 14;
        iconName = "workout_icon";
        break;
      case CustomIconType.others:
        gradient = const [
          Color.fromRGBO(136, 136, 159, 1),
          Color.fromRGBO(24, 23, 67, 1),
        ];
        radius = 14;
        iconName = "other_icon";
        break;
      case CustomIconType.add:
        gradient = const [
          Color.fromRGBO(0, 255, 255, 1),
          Color.fromRGBO(37, 77, 222, 1),
        ];
        radius = 23;
        iconName = "add_icon";
        break;
      case CustomIconType.calendar:
        gradient = const [
          Color.fromRGBO(255, 255, 255, 1),
          Color.fromRGBO(255, 255, 255, 1),
        ];
        radius = 28;
        iconName = "calendar_icon";
        break;
      case CustomIconType.select:
        gradient = const [
          Color.fromRGBO(254, 30, 154, 1),
          Color.fromRGBO(37, 77, 222, 1),
        ];
        radius = 23;
        iconName = "true_icon";
        break;
      case CustomIconType.cancel:
        gradient = const [
          Color.fromRGBO(24, 23, 67, 1),
          Color.fromRGBO(136, 136, 159, 1),
        ];
        radius = 28;
        iconName = "cross_icon";
        break;
      case CustomIconType.done:
        gradient = const [
          Color.fromRGBO(254, 30, 154, 1),
          Color.fromRGBO(37, 77, 222, 1),
        ];
        radius = 28;
        iconName = "done_icon";
        break;
    }
  }

  late final List<Color> gradient;
  late final String iconName;
  final CustomIconType iconType;
  late final double radius;

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: _size.height(radius * 2),
      height: _size.height(radius * 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: gradient,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: iconType != CustomIconType.calendar
                ? gradient.first.withOpacity(0.3)
                : const Color.fromRGBO(24, 23, 67, 0.3),
            offset: const Offset(0, 3),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SvgPicture.asset(
        MyPath.icons_path + iconName + MyPath.icons_extension,
        color: iconType == CustomIconType.select ? Colors.white : null,
      ),
    );
  }
}
