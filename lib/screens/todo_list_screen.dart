import 'package:flutter/material.dart';

import '../models/size.dart';
import '../models/task_info.dart';
import '../widgets/background_stack.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_icons.dart';
import '../widgets/task_container.dart';

class TodoListScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "todo_list_screen";
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TaskInfo> tasks = [];
  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Scaffold(
      body: SizedBox(
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
                        return TaskContainer(task: tasks[index]);
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
    );
  }

  Align buildBottomNav(Size _size) {
    return Align(
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
            CustomIcon(iconType: CustomIconType.select),
            SizedBox(width: _size.width(46)),
            CustomIcon(iconType: CustomIconType.calendar),
            SizedBox(width: _size.width(46)),
            CustomIcon(iconType: CustomIconType.add),
          ],
        ),
      ),
    );
  }
}
