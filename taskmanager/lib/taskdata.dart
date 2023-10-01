import 'package:flutter/material.dart';
import 'package:taskmanager/model/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> tasklist = [
    Task(taskname: 'eat food', ischecked: false),
    Task(taskname: 'sleep', ischecked: false),
    Task(taskname: 'run', ischecked: false),
    Task(taskname: 'have fun', ischecked: false),
  ];

  void addtask(String gotinput) {
    String sendtext = gotinput;
    tasklist.add(Task(taskname: sendtext));
    print(tasklist);
    for (var i in tasklist) {
      print(i.taskname);
    }
    notifyListeners();
  }

  void removetask() {
    tasklist.removeWhere((task) => task.ischecked);
    notifyListeners();
  }

  void changecheck(int index, bool got) {
    if (got == true) {
      tasklist[index].ischecked = got;
    } else {
      tasklist[index].ischecked = false;
    }

    notifyListeners();
  }
}
