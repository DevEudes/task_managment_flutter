class Task {
  int? id;
  String title;
  DateTime dueDate;
  bool completed;

  Task({
    this.id,
    required this.title,
    required this.dueDate,
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'dueDate': dueDate.toIso8601String(),
      'completed': completed ? 1 : 0,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      dueDate: DateTime.parse(map['dueDate']),
      completed: map['completed'] == 1,
    );
  }

  Task copyWith({
    int? id,
    String? title,
    DateTime? dueDate,
    bool? completed,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      completed: completed ?? this.completed,
    );
  }
}
