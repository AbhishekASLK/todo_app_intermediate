// ====================== MODEL CLASS ===============================

class ToDoModelClass {
  int? id;
  String title;
  String description;
  String date;
  String category;
  int? completed = 0;
  ToDoModelClass({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.completed,
  });

  Map<String, dynamic> taskMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'category': category,
      'completed': completed,
    };
  }

  @override
  String toString() {
    return 'id:$id,title:$title,description:$description,data:$date,category:$category,completed:$completed';
  }
}
