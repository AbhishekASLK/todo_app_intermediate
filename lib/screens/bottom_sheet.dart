import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_intermediate/main.dart';
import 'package:todo_app_intermediate/model/todomodel.dart';
import 'package:todo_app_intermediate/screens/todo_app.dart';

class BottomSheetHotReload extends StatefulWidget {
  final bool? isEdit;
  final ToDoModelClass? todoObject;
  // ignore: prefer_typing_uninitialized_variables
  final homeState;
  const BottomSheetHotReload(
      {super.key, this.isEdit, this.todoObject, this.homeState});

  @override
  State<BottomSheetHotReload> createState() => _BottomSheetHotReloadState();
}

String selectedCategory = '';

class _BottomSheetHotReloadState extends State<BottomSheetHotReload> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ClipRRect(
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
                            widget.homeState(() {
                              widget.isEdit!
                                  ? submit(
                                      true,
                                      widget.homeState,
                                      todoObj: widget.todoObject,
                                    )
                                  : submit(false, widget.homeState);
                            });
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
      ),
    );
  }

  // ====================== SUBMIT METHOD ===============================
  void submit(bool isEdit, homeState, {ToDoModelClass? todoObj}) async {
    bool validSubmit = false;
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty &&
        selectedCategory.isNotEmpty) {
      validSubmit = true;
      if (!isEdit) {
        ToDoModelClass obj = ToDoModelClass(
          title: titleController.text,
          description: descriptionController.text,
          date: dateController.text,
          category: selectedCategory,
          completed: 0,
        );
        await insertTask(obj);
        allTasks = await getTasks();
        homeState(() {
          updateLists();
        });
      } else {
        ToDoModelClass obj = ToDoModelClass(
          id: todoObj!.id,
          title: titleController.text,
          description: descriptionController.text,
          date: dateController.text,
          category: selectedCategory,
          completed: todoObj.completed,
        );
        await insertTask(obj);
        allTasks = await getTasks();
        homeState(() {
          updateLists();
        });
      }
      if (validSubmit) {
        Navigator.pop(context);
      }
    }
  }

  void updateLists() {
    filterOnGoingTasks();
    filterCompletedTasks();
    updateDisplayList('All');
    if (status == 'All') {
      searchList = allTasks;
    } else if (status == 'Completed') {
      searchList = completedTasks;
    } else if (status == 'Ongoing') {
      searchList = ongoingTasks;
    }
  }
}
