import 'package:flutter/material.dart';
import 'package:task_managment_flutter/TaskDetail.dart';
import 'package:task_managment_flutter/TaskList.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Task manager"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          leading: IconButton(icon: const Icon(Icons.menu), onPressed: () { print("Menu"); },),
        ),
        body: const TaskListScreen()
    );
  }
}


