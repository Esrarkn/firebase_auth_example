import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;
  final String scheduledDate;
  final bool isCompleted;
  final Function(bool?) onCheckboxChanged;

  const TaskCard({
    super.key,
    required this.color,
    required this.headerText,
    required this.descriptionText,
    required this.scheduledDate,
    required this.isCompleted,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isCompleted ? Colors.grey[300] : color, // Gri renk ve üzeri çizili
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(
          headerText,
          style: TextStyle(
            decoration:
                isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              descriptionText,
              style: TextStyle(
                color: isCompleted
                    ? Colors.grey
                    : Colors.black, // Açıklama tamamlandığında gri
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              scheduledDate,
              style: TextStyle(
                color: isCompleted
                    ? Colors.grey
                    : Colors.black, // Açıklama tamamlandığında gri
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: isCompleted,
          onChanged: onCheckboxChanged,
        ),
      ),
    );
  }
}
