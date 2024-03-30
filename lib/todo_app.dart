import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_intermediate/main.dart';
import 'package:todo_app_intermediate/model/todomodel.dart';

// ====================== CONTROLLERS =============================
TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController dateController = TextEditingController();

// ====================== TASK LIST ===============================

List<ToDoModelClass> tasks = tasksFromDB;

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  List<Icon> listIcon = const [
    Icon(
      Icons.school_outlined,
    ),
    Icon(
      Icons.business_outlined,
    ),
    Icon(
      Icons.person_outlined,
    ),
  ];
  // ====================== BUILD METHOD ===============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 71, 113, 1),
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
                  Text(
                    'Your Pathway to',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    'Productivity!',
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
                color: Color.fromRGBO(250, 205, 205, 1),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: (tasks.isEmpty)
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
                              height: 250,
                              width: 250,
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
                          'TO DO LIST',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            child: TextField(
                              onChanged: (value) {},
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'All',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Ongoing',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_up,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Completed',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_up_outlined,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        todoCard(),
                      ],
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          clearController();
          myBottomSheet(false);
        },
        child: Image.asset(
          'assets/add_button.png',
          height: 52,
          width: 52,
        ),
      ),
    );
  }

  Expanded todoCard() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 3,
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
                          shape: BoxShape.circle,
                        ),
                        height: 32,
                        width: 32,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              editTask(index, tasks[index]);
                            });
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
                          shape: BoxShape.circle,
                        ),
                        height: 32,
                        width: 32,
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              deleteTask(tasks[index]);
                            });
                            tasks = await getTasks();
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                  gradient: LinearGradient(
                    stops: [0.1, 0.9],
                    colors: [
                      Color.fromRGBO(245, 71, 113, 1),
                      Color.fromRGBO(152, 83, 206, 1),
                    ],
                  ),
                ),
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
                      child: const Icon(
                        Icons.school,
                      ),
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
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            tasks[index].description,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            tasks[index].date,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.radio_button_unchecked,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ====================== EDIT METHOD ===============================
  void editTask(int index, ToDoModelClass? todoObj) {
    setState(() {});
    titleController.text = todoObj!.title;
    descriptionController.text = todoObj.description;
    dateController.text = todoObj.date;
    myBottomSheet(true, todoObj);
  }

  void deleteTask(ToDoModelClass obj) async {
    deleteTasks(obj.id);
    tasks = await getTasks();
    setState(() {});
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
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BottomSheetHotReload(
          isEdit: isEdit,
          todoObject: todoObject,
        );
      },
    );
  }
}

class BottomSheetHotReload extends StatefulWidget {
  final bool? isEdit;
  final ToDoModelClass? todoObject;
  const BottomSheetHotReload({super.key, this.isEdit, this.todoObject});

  @override
  State<BottomSheetHotReload> createState() => _BottomSheetHotReloadState();
}

class _BottomSheetHotReloadState extends State<BottomSheetHotReload> {
  String selectedCategory = '';
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: MediaQuery.of(context).viewInsets.top,
          ),
          child: SizedBox(
            height: 600,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create Task',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Title',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Description',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: 3,
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Date',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    readOnly: true,
                    controller: dateController,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2030),
                      );
                      if (pickedDate != null) {
                        String formatDate =
                            DateFormat.yMMMd().format(pickedDate);
                        setState(() {
                          dateController.text = formatDate;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2030),
                          );
                          if (pickedDate != null) {
                            String formatDate =
                                DateFormat.yMMMd().format(pickedDate);
                            setState(() {
                              dateController.text = formatDate;
                            });
                          }
                        },
                        child: const Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Educational';
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.school_outlined,
                              size: 30,
                              color: (selectedCategory != 'Educational')
                                  ? Colors.white
                                  : Colors.yellow,
                            ),
                            Text(
                              'Educational',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Business';
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              size: 30,
                              Icons.business_outlined,
                              color: (selectedCategory != 'Business')
                                  ? Colors.white
                                  : Colors.yellow,
                            ),
                            Text(
                              'Business',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Personal';
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              size: 30,
                              Icons.person_outline,
                              color: (selectedCategory != 'Personal')
                                  ? Colors.white
                                  : Colors.yellow,
                            ),
                            Text(
                              'Personal',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.isEdit!
                              ? submit(
                                  true,
                                  widget.todoObject,
                                )
                              : submit(false);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(89, 57, 241, 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Submit',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future insertAndFetch(ToDoModelClass obj) async {
    await insertTask(obj);
    tasks = await getTasks();
  }

  // ====================== SUBMIT METHOD ===============================
  void submit(bool isEdit, [ToDoModelClass? todoObj]) async {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (!isEdit) {
        ToDoModelClass obj = ToDoModelClass(
          title: titleController.text,
          description: descriptionController.text,
          date: dateController.text,
          completed: 0,
        );
        await insertAndFetch(obj);
      } else {
        ToDoModelClass obj = ToDoModelClass(
          id: todoObj!.id,
          title: titleController.text,
          description: descriptionController.text,
          date: dateController.text,
          completed: 0,
        );
        await insertAndFetch(obj);
      }
      setState(() {});
    }
  }
}
