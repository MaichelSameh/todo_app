import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/palette.dart';
import '../models/size.dart';

class CalendarBar extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(DateTime)? onChange;
  CalendarBar({Key? key, required this.selectedDate, this.onChange})
      : super(key: key);

  final ScrollController controller = ScrollController(initialScrollOffset: 10);
  List<DateTime> getWeekDates() {
    final DateTime weekStartDate =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    List<DateTime> dates = [];
    for (int i = 0; i < 7; i++) {
      dates.add(weekStartDate.add(Duration(days: i)));
    }
    return dates;
  }

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    controller.addListener(() {
      if (controller.position.pixels > 0 && controller.position.atEdge) {
        controller.jumpTo(10);
        (onChange ?? (_) {})(selectedDate
            .subtract(Duration(days: selectedDate.weekday - 1))
            .add(const Duration(days: 10)));
      } else if (controller.position.pixels == 0) {
        (onChange ?? (_) {})(selectedDate
            .subtract(Duration(days: selectedDate.weekday - 1))
            .subtract(const Duration(days: 4)));
        controller.jumpTo(10);
      }
    });
    return SizedBox(
      height: _size.height(80),
      width: _size.screenWidth(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        controller: controller,
        children: [
          SizedBox(
            width: _size.screenWidth() + 20,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: _size.height(65),
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: getWeekDates()
                      .map<Widget>(
                        (date) => date == selectedDate
                            ? Container(
                                width: _size.width(75),
                                height: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: MyPalette.blue_gradient,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_size.width(8)),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      DateFormat("dd").format(date),
                                      style: const TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    ),
                                    Text(
                                      DateFormat("E").format(date),
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () => (onChange ?? (_) {})(date),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        DateFormat("dd").format(date),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        DateFormat("E").format(date),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      )
                      .toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
