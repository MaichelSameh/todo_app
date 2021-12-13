import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../config/path.dart';
import '../models/size.dart';
import '../models/task_info.dart';
import 'custom_icons.dart';

enum TaskContainerMode { normal, select, date, done }

class TaskContainer extends StatelessWidget {
  const TaskContainer({
    Key? key,
    required this.task,
    this.mode = TaskContainerMode.normal,
    this.onSelect,
    this.selected = false,
  }) : super(key: key);

  final TaskInfo task;
  final TaskContainerMode mode;
  final void Function(bool)? onSelect;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return GestureDetector(
      onTap: mode != TaskContainerMode.select
          ? null
          : () => (onSelect ?? (_) {})(!selected),
      child: Row(
        children: [
          if (mode == TaskContainerMode.date)
            Row(
              children: [
                Text(
                  DateFormat("hh:mm").format(task.date),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(width: _size.width(15)),
                CircleAvatar(
                  radius: _size.width(4),
                  backgroundColor: CustomIcon(
                    iconType: task.taskType,
                  ).gradient.last.withOpacity(0.3),
                ),
                SizedBox(width: _size.width(8)),
              ],
            ),
          Container(
            width: mode != TaskContainerMode.date
                ? _size.width(380)
                : _size.width(310),
            height: _size.height(65),
            margin: EdgeInsets.symmetric(vertical: _size.height(10)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_size.width(10)),
              color: const Color.fromRGBO(255, 255, 255, 1),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  offset: Offset(0, 4),
                  blurRadius: 8,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (mode != TaskContainerMode.date)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: _size.width(8),
                            vertical: _size.height(10),
                          ),
                          child: mode == TaskContainerMode.done
                              ? SvgPicture.asset(MyPath.icons_path +
                                  "bold_true_icon" +
                                  MyPath.icons_extension)
                              : CircleAvatar(
                                  radius: _size.width(4),
                                  backgroundColor: CustomIcon(
                                    iconType: task.taskType,
                                  ).gradient.last.withOpacity(0.3),
                                ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _size.width(14)),
                  child: Row(
                    children: [
                      CustomIcon(
                        iconType: task.taskType,
                      ),
                      SizedBox(width: _size.width(14)),
                      SizedBox(
                        width: _size
                            .width(mode != TaskContainerMode.date ? 240 : 230),
                        height: _size.height(20),
                        child: Text(
                          task.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      const Spacer(),
                      if (mode == TaskContainerMode.normal)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat("dd " + DateFormat.ABBR_MONTH)
                                  .format(task.date),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: _size.height(5)),
                            Text(
                              DateFormat("hh:mm").format(task.date),
                              style: const TextStyle(
                                color: Color.fromRGBO(24, 23, 67, 0.6),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      if (TaskContainerMode.select == mode)
                        Container(
                          width: _size.height(27),
                          height: _size.height(27),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(_size.width(6)),
                            border: Border.all(
                              color: const Color.fromRGBO(245, 245, 245, 1),
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(254, 30, 154, 0.1),
                                offset: Offset(0, 2),
                                blurRadius: 4,
                                spreadRadius: 0.5,
                              ),
                            ],
                          ),
                          child: selected
                              ? SvgPicture.asset(
                                  MyPath.icons_path +
                                      "true_icon" +
                                      MyPath.icons_extension,
                                )
                              : null,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
