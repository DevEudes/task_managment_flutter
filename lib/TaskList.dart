import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates
import 'AddTask.dart';
import 'TaskDetail.dart';
import 'models/DatabaseHelper.dart';
import 'models/Task.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late Future<List<Task>> _taskListFuture;
  List<Task> _staticTasks = [
    Task(id: 1, title: 'Faire le menage', dueDate: DateTime.now(), completed: false),
    Task(id: 2, title: 'Faire les courses', dueDate: DateTime.now(), completed: true),
    Task(id: 3, title: 'Appeler ma mere', dueDate: DateTime.now(), completed: false),
  ];

  @override
  void initState() {
    super.initState();
    _refreshTaskList();
  }

  Future<void> _refreshTaskList() async {
    setState(() {
      _taskListFuture = Future.value(_staticTasks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Task>>(
        future: _taskListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(task.title, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Due: ${DateFormat.yMMMd().format(task.dueDate)}', style: TextStyle(color: Colors.blueAccent)),
                    trailing: Checkbox(
                      value: task.completed,
                      onChanged: (value) {
                        setState(() {
                          task.completed = value ?? false;
                        });
                        // No need to update the database for static tasks
                      },
                      activeColor: Colors.blue,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailsScreen(task: task),
                        ),
                      );
                    },
                    tileColor: task.completed ? Colors.blue[100] : Colors.white,
                    leading: Icon(
                      task.completed ? Icons.check_circle_outline : Icons.radio_button_unchecked,
                      color: Colors.blue,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(),
            ),
          );
          _refreshTaskList();
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}
