import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/size.dart';
import '../models/task_info.dart';
import '../services/db_helper.dart';
import '../widgets/widgets.dart';
import 'todo_list_screen.dart';

class CalendarScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "calendar_screen";
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<TaskInfo> tasks = [];
  bool selectMode = false;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    initTasks();
    super.initState();
  }

  Future<void> initTasks() async {
    tasks = await DBHelper().getTasksByDate(selectedDate);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (selectMode) {
            setState(() {
              selectMode = !selectMode;
            });
            return false;
          }
          return true;
        },
        child: SizedBox(
          height: _size.screenHeight() + MediaQuery.of(context).padding.top,
          child: Stack(
            children: [
              const BackgroundStack(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width(20)),
                      child: CustomAppBar(
                          title: DateFormat(DateFormat.MONTH + " yyyy")
                              .format(selectedDate)),
                    ),
                  ),
                  SizedBox(height: _size.height(20)),
                  CalendarBar(
                    selectedDate: selectedDate,
                    onChange: (date) {
                      setState(() {
                        selectedDate = date;
                      });
                      initTasks();
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        top: _size.height(15),
                        left: _size.width(20),
                        right: _size.width(20),
                      ),
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onLongPress: () {
                            setState(() {
                              selectMode = true;
                            });
                          },
                          onTap: () {
                            openTaskDetails(context, tasks[index]);
                          },
                          child: TaskContainer(
                            task: tasks[index],
                            mode: selectMode
                                ? TaskContainerMode.select
                                : TaskContainerMode.date,
                          ),
                        );
                      },
                      itemCount: tasks.length,
                    ),
                  ),
                ],
              ),
              buildBottomNav(_size)
            ],
          ),
        ),
      ),
    );
  }

  Align buildBottomNav(Size _size) {
    return selectMode
        ? Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: _size.height(260),
              width: double.infinity,
              padding: EdgeInsets.only(bottom: _size.height(40)),
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromRGBO(255, 255, 255, 0.8),
                    Color.fromRGBO(255, 255, 255, 0),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectMode = !selectMode;
                      });
                    },
                    child: CustomIcon(iconType: CustomIconType.cancel),
                  ),
                  SizedBox(width: _size.width(46)),
                  CustomIcon(iconType: CustomIconType.done),
                ],
              ),
            ),
          )
        : Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: _size.height(260),
              width: double.infinity,
              padding: EdgeInsets.only(bottom: _size.height(40)),
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromRGBO(255, 255, 255, 0.8),
                    Color.fromRGBO(255, 255, 255, 0),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectMode = !selectMode;
                      });
                    },
                    child: CustomIcon(iconType: CustomIconType.select),
                  ),
                  SizedBox(width: _size.width(46)),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(TodoListScreen.route_name);
                    },
                    child: CustomIcon(iconType: CustomIconType.menu),
                  ),
                  SizedBox(width: _size.width(46)),
                  GestureDetector(
                    onTap: () async {
                      await addNewTask(context, selectedDate);
                      initTasks();
                    },
                    child: CustomIcon(iconType: CustomIconType.add),
                  ),
                ],
              ),
            ),
          );
  }
}
