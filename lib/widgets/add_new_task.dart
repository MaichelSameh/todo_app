import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/palette.dart';
import '../models/size.dart';
import '../models/task_info.dart';
import '../services/db_helper.dart';
import 'custom_icons.dart';

Future<void> addNewTask(BuildContext context, [DateTime? date]) async {
  await showDialog(
    context: context,
    builder: (_) {
      return _AddNewTaskScreen(
        date: date ??
            DateTime.now().add(
              const Duration(days: 1),
            ),
      );
    },
  );
}

class _AddNewTaskScreen extends StatefulWidget {
  const _AddNewTaskScreen({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  @override
  __AddNewTaskScreenState createState() => __AddNewTaskScreenState();
}

class __AddNewTaskScreenState extends State<_AddNewTaskScreen> {
  DateTime date = DateTime.now();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  CustomIconType selectedType = CustomIconType.others;
  bool showError = false;

  @override
  void initState() {
    date = widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Card(
            child: Container(
              width: _size.width(350),
              height: _size.screenHeight(),
              padding: EdgeInsets.symmetric(
                horizontal: _size.width(20),
                vertical: _size.height(8),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_size.width(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NEW TASK",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 20,
                        ),
                  ),
                  SizedBox(height: _size.height(31)),
                  Text(
                    "Icon",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 12,
                          color: const Color.fromRGBO(24, 23, 67, 0.2),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: _size.height(40),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: CustomIconType.values
                          .map<Widget>((icon) => (icon == CustomIconType.add ||
                                  icon == CustomIconType.calendar ||
                                  icon == CustomIconType.cancel ||
                                  icon == CustomIconType.done ||
                                  icon == CustomIconType.menu ||
                                  icon == CustomIconType.select)
                              ? const SizedBox()
                              : GestureDetector(
                                  onTap: () {
                                    selectedType = icon;
                                    setState(() {});
                                  },
                                  child: SizedBox(
                                    width: _size.width(47),
                                    child: Stack(
                                      children: [
                                        Row(
                                          children: [
                                            if (selectedType == icon)
                                              CircleAvatar(
                                                radius: 3,
                                                backgroundColor:
                                                    CustomIcon(iconType: icon)
                                                        .gradient
                                                        .first,
                                              ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: _size.width(8)),
                                          child: CustomIcon(iconType: icon),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: _size.height(20)),
                  Text(
                    "Name",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 12,
                          color: const Color.fromRGBO(24, 23, 67, 0.2),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Enter the task title",
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 12,
                                color: const Color.fromRGBO(24, 23, 67, 0.2),
                              ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 2,
                    decoration: BoxDecoration(
                      gradient:
                          const LinearGradient(colors: MyPalette.logo_gradient),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(height: _size.height(30)),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 12,
                          color: const Color.fromRGBO(24, 23, 67, 0.2),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: _size.height(10)),
                  Container(
                    height: _size.height(100),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(24, 23, 67, 0.2),
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(_size.width(8)),
                    ),
                    child: TextField(
                      controller: descriptionController,
                      expands: true,
                      minLines: null,
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        hintText: "Enter the task description",
                        hintStyle:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 12,
                                  color: const Color.fromRGBO(24, 23, 67, 0.2),
                                ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: _size.height(30)),
                  GestureDetector(
                    onTap: () async {
                      selectedDate = (await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 20)),
                            initialDate: selectedDate,
                          )) ??
                          selectedDate;
                      TimeOfDay time = (await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(
                                  hour: selectedDate.hour,
                                  minute: selectedDate.minute))) ??
                          TimeOfDay(
                              hour: selectedDate.hour,
                              minute: selectedDate.minute);
                      selectedDate = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        time.hour,
                        time.minute,
                      );
                      setState(() {});
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                fontSize: 12,
                                color: const Color.fromRGBO(24, 23, 67, 0.2),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: _size.height(10)),
                        Text(
                          DateFormat("dd-EEEEEE-yyyy hh:mm")
                              .format(selectedDate),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                fontSize: 12,
                                color: const Color.fromRGBO(24, 23, 67, 0.2),
                              ),
                        ),
                        SizedBox(height: _size.height(10)),
                        Container(
                          width: double.infinity,
                          height: 2,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(24, 23, 67, 0.12),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(height: _size.height(30)),
                        GestureDetector(
                          onTap: () {
                            if (nameController.text.isEmpty ||
                                descriptionController.text.isEmpty) {
                              setState(() {
                                showError = true;
                              });
                            } else {
                              DBHelper().insertTask(
                                TaskInfo(
                                    date: selectedDate,
                                    description: descriptionController.text,
                                    taskType: selectedType,
                                    id: 1,
                                    name: nameController.text,
                                    status: CustomIconStatus.none),
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            height: _size.height(50),
                            width: _size.width(140),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(_size.height(50)),
                              gradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: MyPalette.blue_gradient,
                              ),
                            ),
                            child: Text(
                              "Add",
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
                  const Spacer(),
                  if (showError)
                    Text(
                      "You need to enter a title and description",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 12, color: Colors.red),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
