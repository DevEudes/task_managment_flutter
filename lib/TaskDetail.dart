import 'package:flutter/material.dart';
import 'models/Task.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task task;

  TaskDetailsScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.title,
                  color: Colors.blue,
                ),
                SizedBox(width: 8),
                Text(
                  'Title:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              task.title,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.blue,
                ),
                SizedBox(width: 8),
                Text(
                  'Due Date:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              '${task.dueDate}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  task.completed ? Icons.check_circle : Icons.cancel,
                  color: task.completed ? Colors.green : Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  'Completed:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              task.completed ? 'Yes' : 'No',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
