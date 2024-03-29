// ====================== MODEL CLASS ===============================

class ToDoModelClass {
  int? id;
  String title;
  String description;
  String date;
  ToDoModelClass({
    this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> taskMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
    };
  }

  @override
  String toString() {
    return 'id:$id,title:$title,description:$description,data:$date';
  }
}
