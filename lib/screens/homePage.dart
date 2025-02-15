import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_example/widgets/colors.dart';
import 'package:firebase_auth_example/widgets/dateSelector.dart';
import 'package:firebase_auth_example/widgets/floatingActionButton.dart';
import 'package:firebase_auth_example/widgets/taskCard.dart';
import 'package:firebase_auth_example/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now(); // Başlangıçta bugünü al
  User? user = FirebaseAuth.instance.currentUser;

  void onDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate; // Seçilen tarihi kaydet
    });
  }

  Stream<QuerySnapshot> getTasksForDate(DateTime selectedDate) {
    DateTime startOfDay =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    DateTime endOfDay = startOfDay.add(const Duration(days: 1));

    return FirebaseFirestore.instance
        .collection("tasks")
        .where("date", isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where("date", isLessThan: Timestamp.fromDate(endOfDay))
        .snapshots();
  }

  void _updateTask(String taskId, String newTitle, String newDescription) {
    FirebaseFirestore.instance.collection("tasks").doc(taskId).update({
      "title": newTitle,
      "description": newDescription,
    }).then((_) {
      print("Görev başarıyla güncellendi!");
    }).catchError((error) {
      print("Güncelleme hatası: $error");
    });
  }

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /*appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/apple.png'),
                radius: 24,
              ),
            ),
            title: Text(
              user?.displayName ?? 'Kullanıcı Adı Bulunamadı',
              style: TextStyle(
                  color: MyColors.green, // Başlık rengi daha koyu
                  fontFamily: "Shippori",
                  fontSize: 24, // Başlık büyütüldü
                  fontStyle: FontStyle.italic),
            ),
            backgroundColor: MyColors.white), */ // AppBar rengi sabit kaldı

        body: Padding(
          padding: const EdgeInsets.all(16.0), // Daha fazla padding
          child: Center(
            child: Column(
              children: [
                DateSelector(onDateChanged: onDateChanged), // Tarih seçici
                StreamBuilder(
                  stream: getTasksForDate(
                      selectedDate), // Seçilen tarihe göre filtrele
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 200.0),
                        child: Text(
                          "No Data Here! ",
                          style: TextStyle(
                              color: MyColors.green,
                              fontFamily: "Shippori",
                              fontSize: 24,
                              fontStyle: FontStyle.italic),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var taskData = snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;

                          DateTime taskDate =
                              (taskData["date"] as Timestamp).toDate();
                          String formattedDate =
                              DateFormat('dd/MM/yyyy HH:mm:ss')
                                  .format(taskDate);
                          bool isCompleted = taskData["completed"] ?? false;

                          return Slidable(
                            key: ValueKey(snapshot.data!.docs[index].id),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    _updateTask("UtrodMvmDg3PbqvRsvnQ",
                                        "newTitle", "newDescription");
                                  },
                                  backgroundColor: Colors.white70,
                                  foregroundColor: Colors.black,
                                  borderRadius: BorderRadius.circular(15),
                                  icon: Icons.edit,
                                  label: 'Update',
                                  flex: 1,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    FirebaseFirestore.instance
                                        .collection("tasks")
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete();
                                  },
                                  borderRadius: BorderRadius.circular(15),
                                  backgroundColor:
                                      const Color.fromARGB(199, 255, 82, 82),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  flex: 1,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TaskCard(
                                    color: hexToColor(
                                        taskData["color"] ?? "#FFFFFF"),
                                    headerText: taskData["title"] ?? "Untitled",
                                    descriptionText: taskData["description"] ??
                                        "No description",
                                    scheduledDate: formattedDate,
                                    isCompleted: isCompleted,
                                    onCheckboxChanged: (newValue) {
                                      FirebaseFirestore.instance
                                          .collection("tasks")
                                          .doc(snapshot.data!.docs[index].id)
                                          .update({"completed": newValue});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: floatingActionButton(),
      ),
    );
  }
}
