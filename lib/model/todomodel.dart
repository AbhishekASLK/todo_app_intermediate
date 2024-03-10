// ====================== MODEL CLASS ===============================

class ToDoModelClass {
  String title;
  String description;
  String date;
  int? id;
  ToDoModelClass({
    required this.title,
    required this.description,
    required this.date,
    this.id,
  });

  Map<String, String> taskMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
    };
  }
}
