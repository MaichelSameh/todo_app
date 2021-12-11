import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/size.dart';
import '../models/task_info.dart';
import 'custom_icons.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({
    Key? key,
    required this.task,
  }) : super(key: key);

  final TaskInfo task;

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _size.width(8),
                  vertical: _size.height(10),
                ),
                child: CircleAvatar(
                  radius: _size.width(4),
                  backgroundColor: CustomIcon(
                    iconType: task.taskType,
                  ).gradient.last.withOpacity(0.3),
                ),
              ),
            ],
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
                  width: _size.width(240),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
