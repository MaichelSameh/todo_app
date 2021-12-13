import 'package:flutter/material.dart';
import 'package:todo/services/db_helper.dart';

import '../models/size.dart';
import '../models/task_info.dart';
import '../widgets/widgets.dart';
import 'calendar_screen.dart';

class TodoListScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "todo_list_screen";
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TaskInfo> tasks = [];

  bool selectMode = false;

  @override
  void initState() {
    initTasks();
    super.initState();
  }

  Future<void> initTasks() async {
    tasks = await DBHelper().getAllTasks();
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _size.width(20)),
                child: Column(
                  children: [
                    const CustomAppBar(title: "TODO"),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: _size.height(15)),
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
                                  : TaskContainerMode.normal,
                            ),
                          );
                        },
                        itemCount: tasks.length,
                      ),
                    ),
                  ],
                ),
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
                          .pushNamed(CalendarScreen.route_name);
                    },
                    child: CustomIcon(iconType: CustomIconType.calendar),
                  ),
                  SizedBox(width: _size.width(46)),
                  GestureDetector(
                    onTap: () async {
                      await addNewTask(context);
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
