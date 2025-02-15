import 'package:firebase_auth_example/screens/addNewTaskPage.dart';
import 'package:flutter/material.dart';

class floatingActionButton extends StatelessWidget {
  const floatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddNewTask()));
      },
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(Icons.add, size: 28, color: Colors.white),
    );
  }
}
