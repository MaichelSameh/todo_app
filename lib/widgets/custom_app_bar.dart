import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/path.dart';
import '../models/size.dart';
import '../screens/done_tasks_screen.dart';

class CustomAppBar extends StatelessWidget {
  final double? menuWidth;
  final int struckNumber;
  final String title;
  final bool goBack;
  final bool showMenu;
  const CustomAppBar({
    Key? key,
    this.menuWidth,
    this.struckNumber = 2,
    required this.title,
    this.goBack = false,
    this.showMenu = true,
  }) : super(key: key);

  List<Widget> generateStruck(Size _size) {
    List<Widget> list = [];
    for (int i = 0; i < struckNumber; i++) {
      list.add(
        Container(
          width: menuWidth ?? _size.width(i % 2 == 0 ? 15 : 23),
          height: _size.height(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_size.height(5)),
            gradient: const LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color.fromRGBO(254, 30, 154, 1),
                Color.fromRGBO(254, 166, 76, 1),
              ],
            ),
          ),
        ),
      );
      if (i != struckNumber - 1) list.add(SizedBox(height: _size.height(5)));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top + 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(DoneTasksScreen.route_name);
              },
              child: Padding(
                padding: EdgeInsets.all(_size.width(5)),
                child: showMenu
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: generateStruck(_size),
                      )
                    : null,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(24, 23, 67, 1),
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.all(_size.width(5)),
                child: goBack
                    ? SvgPicture.asset(
                        MyPath.icons_path +
                            "back_icon" +
                            MyPath.icons_extension,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
