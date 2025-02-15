import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  final DateTime initialDate; // 🔹 Başlangıç tarihi olarak geçilecek

  const Calendar({super.key, required this.initialDate});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime selectedDate; // 🔹 Seçilen tarihi saklayacak değişken

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate; // Başlangıç değerini al
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Date")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Selected Date: ${DateFormat('dd/MM/yyyy').format(selectedDate)}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              child: const Text("Pick Date"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                    context, selectedDate); // 🔹 Seçilen tarihi geri gönder
              },
              child: const Text("Confirm Date"),
            ),
          ],
        ),
      ),
    );
  }
}
