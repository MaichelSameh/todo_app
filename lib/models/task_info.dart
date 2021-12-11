import 'package:intl/intl.dart';

class TaskInfo {
  late DateTime _date;
  late String _description;
  late String _iconName;
  late int _id;
  late String _name;

  DateTime get date => _date;
  String get description => _description;
  String get iconName => _iconName;
  int get id => _id;
  String get name => _name;

  TaskInfo({
    required DateTime date,
    required String description,
    required String iconName,
    required int id,
    required String name,
  }) {
    _date = date;
    _description = description;
    _iconName = iconName;
    _id = id;
    _name = name;
  }

  TaskInfo.fromLocalDB(Map<String, dynamic> data) {
    _date = DateTime.parse(data["date"]);
    _description = data["description"];
    _iconName = data["icon_name"];
    _id = data["id"];
    _name = data["name"];
  }

  Map<String, dynamic> toMap() {
    return {
      "date": DateFormat("yyyy-MM-dd hh:mm:ss").format(date),
      "description": description,
      "icon_name": iconName,
      "name": name,
    };
  }

  @override
  String toString() {
    return 'TaskInfo(date: $date, description: $description, iconName: $iconName, id: $id, name: $name)';
  }
}
