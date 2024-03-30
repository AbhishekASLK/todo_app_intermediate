// ====================== MODEL CLASS ===============================

class ToDoModelClass {
  int? id;
  String title;
  String description;
  String date;
  int? completed = 0;
  ToDoModelClass({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.completed,
  });

  Map<String, dynamic> taskMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'completed': completed,
    };
  }

  @override
  String toString() {
    return 'id:$id,title:$title,description:$description,data:$date,completed:$completed';
  }
}
