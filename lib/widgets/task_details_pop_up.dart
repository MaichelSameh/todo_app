import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/palette.dart';
import '../models/task_info.dart';
import '../models/size.dart';
import 'custom_icons.dart';

void openTaskDetails(BuildContext context, TaskInfo task) {
  Size _size = Size(context);
  Color color = const Color.fromRGBO(24, 23, 67, 1);
  showDialog(
    context: context,
    builder: (_) {
      return Center(
        child: Container(
          width: _size.width(320),
          padding: EdgeInsets.all(_size.height(18)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIcon(iconType: task.taskType),
              SizedBox(height: _size.height(18)),
              Container(
                constraints: BoxConstraints(maxHeight: _size.height(50)),
                child: Text(
                  task.name,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold, color: color),
                ),
              ),
              SizedBox(height: _size.height(8)),
              Text(
                DateFormat("dd EEE hh:mm").format(task.date),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16, fontWeight: FontWeight.bold, color: color),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: DateFormat("dd EEE").format(task.date),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: color),
                    ),
                    TextSpan(
                      text: DateFormat(" hh:mm").format(task.date),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 12, color: color.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: _size.height(36)),
              Container(
                constraints: BoxConstraints(maxHeight: _size.height(50)),
                child: Text(
                  "description",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 12, fontWeight: FontWeight.bold, color: color),
                ),
              ),
              SizedBox(height: _size.height(18)),
              Row(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: _size.width(270),
                      maxHeight: _size.height(400),
                    ),
                    child: Text(
                      task.description,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 12, color: color.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: _size.height(30)),
              GestureDetector(
                onTap: () {
                  Navigator.pop(_);
                },
                child: Container(
                  height: _size.height(50),
                  width: _size.width(140),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_size.height(50)),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: MyPalette.blue_gradient,
                    ),
                  ),
                  child: Text(
                    "Done",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
