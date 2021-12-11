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
    _date = DateTime.parse(data["date"]);
    _description = data["description"];
    _taskType = data["icon_name"];
    _id = data["id"];
    _name = data["name"];
    _status = data["status"];
  }

  Map<String, dynamic> toMap() {
    return {
      "date": DateFormat("yyyy-MM-dd hh:mm:ss").format(date),
      "description": description,
      "icon_name": taskType,
      "name": name,
      "status": status,
    };
  }

  @override
  String toString() {
    return 'TaskInfo(date: $date, description: $description, taskType: $taskType, id: $id, name: $name, status: $status)';
  }
}
