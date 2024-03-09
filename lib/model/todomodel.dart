// ====================== MODEL CLASS ===============================

class ToDoModelClass {
  String title;
  String description;
  String date;
  ToDoModelClass({
    required this.title,
    required this.description,
    required this.date,
  });

  Map<String, String> taskMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
    };
  }
}
