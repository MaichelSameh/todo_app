import 'package:flutter/material.dart';

import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.route_name,
      routes: {
        SplashScreen.route_name: (_) =>
            const SplashScreen(key: Key(SplashScreen.route_name)),
        AddNewTaskScreen.route_name: (_) =>
            const AddNewTaskScreen(key: Key(AddNewTaskScreen.route_name)),
        CalendarScreen.route_name: (_) =>
            const CalendarScreen(key: Key(CalendarScreen.route_name)),
        DoneTasksScreen.route_name: (_) =>
            const DoneTasksScreen(key: Key(DoneTasksScreen.route_name)),
        TodoListScreen.route_name: (_) =>
            const TodoListScreen(key: Key(TodoListScreen.route_name)),
      },
    );
  }
}
