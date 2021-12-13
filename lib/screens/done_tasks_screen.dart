import 'package:flutter/material.dart';
import 'package:todo/services/db_helper.dart';

import '../models/size.dart';
import '../models/task_info.dart';
import '../widgets/widgets.dart';

class DoneTasksScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "done_tasks_screen";
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  State<DoneTasksScreen> createState() => _DoneTasksScreenState();
}

class _DoneTasksScreenState extends State<DoneTasksScreen> {
  List<TaskInfo> tasks = [];

  @override
  void initState() {
    super.initState();
    initTasks();
  }

  Future<void> initTasks() async {
    tasks = await DBHelper().getAllTasks(CustomIconStatus.done);
    setState(() {});
  }

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
                  const CustomAppBar(
                    title: "DONE TASKS",
                    goBack: true,
                    showMenu: false,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: _size.height(15)),
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            openTaskDetails(context, tasks[index]);
                          },
                          child: TaskContainer(
                            task: tasks[index],
                            mode: TaskContainerMode.done,
                          ),
                        );
                      },
                      itemCount: tasks.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
