import 'package:intl/intl.dart';

import '../widgets/custom_icons.dart';

class TaskInfo {
  late DateTime _date;
  late String _description;
  late CustomIconType _taskType;
  late CustomIconStatus _status;
  late int _id;
  late String _name;

  DateTime get date => _date;
  String get description => _description;
  CustomIconType get taskType => _taskType;
  CustomIconStatus get status => _status;
  int get id => _id;
  String get name => _name;

  TaskInfo({
    required DateTime date,
    required String description,
    required CustomIconType taskType,
    required int id,
    required String name,
    required CustomIconStatus status,
  }) {
    _date = date;
    _description = description;
    _taskType = taskType;
    _id = id;
    _name = name;
    _status = status;
  }

  TaskInfo.fromLocalDB(Map<String, dynamic> data) {
    CustomIconType type = CustomIconType.others;
    switch (data["icon_type"]) {
      case 1:
        type = CustomIconType.shopping;
        break;
      case 2:
        type = CustomIconType.sports;
        break;
      case 3:
        type = CustomIconType.visits;
        break;
      case 4:
        type = CustomIconType.parties;
        break;
      case 5:
        type = CustomIconType.workout;
        break;
      case 6:
        type = CustomIconType.others;
        break;
    }
    _date = DateTime.parse(data["date"]);
    _description = data["description"];
    _taskType = type;
    _id = data["id"];
    _name = data["title"];
    _status =
        data["status"] == 1 ? CustomIconStatus.done : CustomIconStatus.none;
  }

  Map<String, dynamic> toMap() {
    int taskType = 6;
    switch (this.taskType) {
      case CustomIconType.shopping:
        taskType = 1;
        break;
      case CustomIconType.sports:
        taskType = 2;
        break;
      case CustomIconType.visits:
        taskType = 3;
        break;
      case CustomIconType.parties:
        taskType = 4;
        break;
      case CustomIconType.workout:
        taskType = 5;
        break;
      case CustomIconType.others:
        taskType = 6;
        break;
      case CustomIconType.add:
        taskType = 6;
        break;
      case CustomIconType.calendar:
        taskType = 6;
        break;
      case CustomIconType.select:
        taskType = 6;
        break;
      case CustomIconType.cancel:
        taskType = 6;
        break;
      case CustomIconType.done:
        taskType = 6;
        break;
      case CustomIconType.menu:
        taskType = 6;
        break;
    }
    return {
      "date": DateFormat("yyyy-MM-dd hh:mm:ss").format(date),
      "description": description,
      "icon_type": taskType,
      "title": name,
      "status": status == CustomIconStatus.done ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'TaskInfo(date: $date, description: $description, taskType: $taskType, id: $id, name: $name, status: $status)';
  }
}
