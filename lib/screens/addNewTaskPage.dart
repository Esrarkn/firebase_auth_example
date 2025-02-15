import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_example/widgets/colors.dart';
import 'package:firebase_auth_example/widgets/utils.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Color _selectedColor = Colors.blue;
  File? file;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> uploadTaskToDb() async {
    try {
      await FirebaseFirestore.instance.collection("tasks").add({
        "title": titleController.text.trim(),
        "description": descriptionController.text.trim(),
        "creator": FirebaseAuth.instance.currentUser!.uid,
        "date": Timestamp.fromDate(selectedDate),
        "postedAt": FieldValue.serverTimestamp(),
        "color": rgbToHex(_selectedColor),
      });
    } catch (e) {
      print("error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add New Task',
            style: TextStyle(
              color: MyColors.green,
              fontFamily: "Shippori",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(
                        fontFamily: "Shippori",
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(
                        fontFamily: "Shippori",
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                ColorPicker(
                  pickersEnabled: const {
                    ColorPickerType.wheel: true,
                  },
                  color: Colors.green,
                  onColorChanged: (Color color) {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  heading: const Text(
                    'Select color',
                    style: TextStyle(
                        fontFamily: "Shippori",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  subheading: const Text(
                    'Select a different shade',
                    style: TextStyle(
                        fontFamily: "Shippori",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      uploadTaskToDb();
                    });
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: MyColors.white),
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(
                      fontSize: 16,
                      color: MyColors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
