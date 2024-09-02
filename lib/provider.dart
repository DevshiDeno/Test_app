import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Task/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> taskList = [];
  List<Task> get _taskList=>taskList ;

  void addTask(Task task,context) {
    _taskList.add(task);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Task added")));
    notifyListeners();
  }

  void deleteTask(int index,context) {
    _taskList.removeAt(index);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Task deleted")));
    notifyListeners();
  }
}
