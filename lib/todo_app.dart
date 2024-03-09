import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_intermediate/model/todomodel.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  // ====================== DATABASE ================================
  dynamic database;

  bool emptyList = true;
  // ====================== CONTROLLERS =============================

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  // ====================== TASK LIST ===============================

  List<ToDoModelClass> tasks = [];

  // ====================== BUILD METHOD ===============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(111, 81, 255, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Good morning!',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    'AbhishekASLK',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(217, 217, 217, 1),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: (emptyList)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/no_tasks.png',
                              height: 300,
                              width: 300,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Nothing to do!',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'CREATE TO DO LIST',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        todoCard(),
                      ],
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          clearController();
          myBottomSheet(false);
        },
        child: Image.asset('assets/add_button.png'),
      ),
    );
  }

  Expanded todoCard() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 30),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Colors.white,
        ),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Container(
              height: 10,
              color: const Color.fromRGBO(217, 217, 217, 1),
            );
          },
          shrinkWrap: true,
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(111, 81, 255, 1),
                              shape: BoxShape.circle),
                          height: 32,
                          width: 32,
                          child: GestureDetector(
                            onTap: () {
                              editTask(tasks[index]);
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(111, 81, 255, 1),
                              shape: BoxShape.circle),
                          height: 32,
                          width: 32,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                deleteTask(tasks[index]);
                              });
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 52,
                      width: 52,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                      child: Image.asset('assets/profile.png'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tasks[index].title,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            tasks[index].description,
                            style: GoogleFonts.poppins(),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            tasks[index].date,
                            style: GoogleFonts.poppins(),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ====================== SUBMIT METHOD ===============================
  void submit(bool isEdit, [ToDoModelClass? todoObj]) async {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      ToDoModelClass obj = ToDoModelClass(
        title: titleController.text,
        description: descriptionController.text,
        date: dateController.text,
      );
      if (!isEdit) {
        setState(() {
          tasks.add(obj);
          if (tasks.isNotEmpty) {
            emptyList = false;
          }
        });
      } else {
        todoObj!.title = titleController.text;
        todoObj.description = descriptionController.text;
        todoObj.date = dateController.text;
      }
    }
  }

  // ====================== SUBMIT METHOD ===============================
  void editTask(ToDoModelClass? todoObj) {
    setState(() {});
    titleController.text = todoObj!.title;
    descriptionController.text = todoObj.description;
    dateController.text = todoObj.date;
    myBottomSheet(true, todoObj);
  }

  void deleteTask(ToDoModelClass todoObj) {
    tasks.remove(todoObj);
    if (tasks.isEmpty) {
      emptyList = true;
    }
  }

  // ====================== CLEAR CONTROLLER METHOD ===============================
  void clearController() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  // ====================== MYBOTTOMSHEET METHOD ===============================
  void myBottomSheet(bool isEdit, [ToDoModelClass? todoObject]) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create ToDo',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const Text('Title'),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Text('Description'),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Text('Date'),
                  TextFormField(
                    readOnly: true,
                    controller: dateController,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2030),
                          );
                          String formatDate =
                              DateFormat.yMMMd().format(pickedDate!);
                          setState(() {
                            dateController.text = formatDate;
                          });
                        },
                        child: const Icon(Icons.calendar_month),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: const ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(
                            Colors.white,
                          ),
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.green,
                          ),
                          fixedSize: MaterialStatePropertyAll(
                            Size(200, 50),
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              isEdit ? submit(true, todoObject) : submit(false);
                            },
                          );
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
