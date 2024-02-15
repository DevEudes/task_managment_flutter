import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'HomePage.dart';
import 'models/DatabaseHelper.dart';
import 'models/Task.dart';


class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  DateTime _dueDate = DateTime.now();
  bool _isCompleted = false;

  void _submitTask() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newTask = Task(title: _title, dueDate: _dueDate, completed: _isCompleted);
      await DatabaseHelper.instance.createTask(newTask); // Utilisez la méthode createTask de DatabaseHelper
      Navigator.of(context).pop(); // Retour à l'écran précédent
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _dueDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.title, color: Colors.blue),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value!;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Due Date: ${DateFormat.yMd().format(_dueDate)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    ElevatedButton(
                      onPressed: _presentDatePicker,
                      child: Text('Choose Date'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
                SwitchListTile(
                  title: Text('Completed'),
                  value: _isCompleted,
                  onChanged: (bool value) {
                    setState(() {
                      _isCompleted = value;
                    });
                  },
                  secondary: Icon(Icons.check, color: Colors.blue),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitTask,
                    child: Text('Add Task'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
