import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_intermediate/screens/bottom_sheet.dart';
import 'package:todo_app_intermediate/main.dart';
import 'package:todo_app_intermediate/model/todomodel.dart';

// ====================== CONTROLLERS =============================
TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController dateController = TextEditingController();

// ====================== TASK LIST ===============================

List<ToDoModelClass> allTasks = tasksFromDB;
List<ToDoModelClass> ongoingTasks = [];
List<ToDoModelClass> completedTasks = [];
List<ToDoModelClass> displayList = allTasks;
List<ToDoModelClass> searchList = [];

void filterOnGoingTasks() {
  ongoingTasks = allTasks.where((element) => element.completed == 0).toList();
}

void filterCompletedTasks() {
  completedTasks = allTasks.where((element) => element.completed == 1).toList();
}

void updateDisplayList(String status) {
  if (status == 'Ongoing') {
    displayList = ongoingTasks;
  } else if (status == 'Completed') {
    displayList = completedTasks;
  } else {
    displayList = allTasks;
  }
}

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

String status = 'All';

class _ToDoAppState extends State<ToDoApp> {
  @override
  void initState() {
    super.initState();
    searchList = displayList;
  }

  bool completed = false;
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
  String pressedButton = 'All';
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
              child: Column(
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
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: SizedBox(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchList = displayList
                                .where((element) => element.title
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
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
                    height: 5,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            pressedButton = 'All';
                            status = 'All';
                            searchList = allTasks;
                            updateDisplayList(status);
                          });
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                8,
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
                                Icon(
                                  (pressedButton == 'All')
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            pressedButton = 'Ongoing';
                            status = 'Ongoing';
                            filterOnGoingTasks();
                            searchList = ongoingTasks;
                            updateDisplayList(status);
                          });
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                8,
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
                                Icon(
                                  (pressedButton == 'Ongoing')
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            pressedButton = 'Completed';
                            status = 'Completed';
                            filterCompletedTasks();
                            searchList = completedTasks;
                            updateDisplayList(status);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                8,
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
                                Icon(
                                  (pressedButton == 'Completed')
                                      ? Icons.arrow_drop_up_outlined
                                      : Icons.arrow_drop_down_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            ),
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
        onTap: () {
          clearController();
          myBottomSheet(false, setState);
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
    if (searchList.isEmpty) {
      return Expanded(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/no_tasks.png',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'No Tasks Found',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 4,
          );
        },
        shrinkWrap: true,
        itemCount: searchList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  SlidableAction(
                    borderRadius: BorderRadius.circular(20),
                    backgroundColor: const Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    onPressed: (context) {
                      setState(() {
                        editTask(index, allTasks[index]);
                      });
                    },
                    icon: Icons.edit,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SlidableAction(
                    borderRadius: BorderRadius.circular(20),
                    backgroundColor: const Color.fromARGB(255, 218, 8, 8),
                    foregroundColor: Colors.white,
                    onPressed: (context) async {
                      setState(() {
                        deleteTask(allTasks[index]);
                      });
                      allTasks = await getTasks();
                    },
                    icon: Icons.delete,
                  ),
                ],
              ),
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
                      child: Icon(
                        (searchList[index].category == 'Educational')
                            ? Icons.school_outlined
                            : (searchList[index].category == 'Business')
                                ? Icons.business_outlined
                                : Icons.person_outlined,
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
                            searchList[index].title,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            searchList[index].description,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            searchList[index].date,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        int? id;
                        String title = '';
                        String description = '';
                        String date = '';
                        String category = '';
                        int? completed;
                        if (status == 'All') {
                          id = allTasks[index].id;
                          title = allTasks[index].title;
                          description = allTasks[index].description;
                          date = allTasks[index].date;
                          category = allTasks[index].category;
                          if (allTasks[index].completed == 0) {
                            completed = 1;
                          } else {
                            completed = 0;
                          }
                        } else if (status == 'Completed') {
                          id = completedTasks[index].id;
                          title = completedTasks[index].title;
                          description = completedTasks[index].description;
                          category = completedTasks[index].category;
                          if (completedTasks[index].completed == 0) {
                            completed = 1;
                          } else {
                            completed = 0;
                          }
                        } else if (status == 'Ongoing') {
                          id = ongoingTasks[index].id;
                          title = ongoingTasks[index].title;
                          description = ongoingTasks[index].description;
                          category = ongoingTasks[index].category;
                          if (ongoingTasks[index].completed == 0) {
                            completed = 1;
                          } else {
                            completed = 0;
                          }
                        }
                        ToDoModelClass newObj = ToDoModelClass(
                          id: id,
                          title: title,
                          description: description,
                          date: date,
                          category: category,
                          completed: completed,
                        );
                        await updateTask(newObj);
                        allTasks = await getTasks();
                        displayList = allTasks;
                        filterOnGoingTasks();
                        filterCompletedTasks();
                        setState(() {});
                        if (status == 'All') {
                          searchList = allTasks;
                        } else if (status == 'Completed') {
                          searchList = completedTasks;
                        } else if (status == 'Ongoing') {
                          searchList = ongoingTasks;
                        }
                        setState(() {});
                      },
                      child: Icon(
                        (searchList[index].completed == 0)
                            ? Icons.circle_outlined
                            : Icons.check_circle,
                        color: Colors.yellow,
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
    selectedCategory = todoObj.category;
    myBottomSheet(true, setState, todoObject: todoObj);
  }

  void deleteTask(ToDoModelClass obj) async {
    deleteTasks(obj.id);
    allTasks = await getTasks();
    displayList = allTasks;
    updateDisplayList(status);
    filterOnGoingTasks();
    filterCompletedTasks();
    if (status == 'All') {
      searchList = allTasks;
    }
    if (status == 'Completed') {
      searchList = completedTasks;
    }
    if (status == 'Ongoing') {
      searchList = ongoingTasks;
    }
    setState(() {});
  }

  // ====================== CLEAR CONTROLLER METHOD ===============================
  void clearController() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  // ====================== MYBOTTOMSHEET METHOD ===============================
  void myBottomSheet(bool isEdit, setState, {ToDoModelClass? todoObject}) {
    if (isEdit) {
      titleController.text = todoObject!.title;
      descriptionController.text = todoObject.description;
      dateController.text = todoObject.date;
      selectedCategory = todoObject.category;
    } else {
      selectedCategory = '';
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BottomSheetHotReload(
          isEdit: isEdit,
          todoObject: todoObject,
          homeState: setState,
        );
      },
    );
    setState(() {});
  }
}
