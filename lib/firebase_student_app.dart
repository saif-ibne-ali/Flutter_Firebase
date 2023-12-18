import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late CollectionReference studentCollectionRef = db.collection('students');
  List<Student> studentList = [];
  final TextEditingController nameTEController = TextEditingController();
  final TextEditingController idTEController = TextEditingController();
  final TextEditingController fieldTEController = TextEditingController();

  Future<void> getStudentData() async {
    final QuerySnapshot result = await studentCollectionRef.get();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    //getStudentData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddStudentBottomSheet,
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: getStudentData,
        child: StreamBuilder(
            stream: studentCollectionRef.orderBy('id').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (snapshot.hasData) {
                studentList.clear();
                for (QueryDocumentSnapshot element in snapshot.data!.docs) {
                  Student student = Student(
                    name: element.get('name'),
                    id: element.get('id'),
                    field: element.get('field'),
                    uniqueId: element.id,
                  );
                  studentList.add(student);
                }
                return ListView.builder(
                    itemCount: studentList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(studentList[index].name),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(studentList[index].id),
                              Text(studentList[index].field),
                            ]),
                        trailing: Wrap(
                          children: [
                            IconButton(
                              onPressed: () {
                                studentCollectionRef
                                    .doc(studentList[index].uniqueId)
                                    .update({
                                  'name': 'Rahi',
                                  'id': '17151039',
                                  'field': 'CSE'
                                });
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                studentCollectionRef
                                    .doc(studentList[index].uniqueId)
                                    .delete();
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    });
              }
              return const SizedBox();
            }),
      ),
    );
  }

  void showAddStudentBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              TextField(
                controller: nameTEController,
              ),
              TextField(
                controller: idTEController,
              ),
              TextField(
                controller: fieldTEController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await studentCollectionRef.add({
                      'name': nameTEController.text.trim(),
                      'id': idTEController.text.trim(),
                      'field': fieldTEController.text.trim(),
                    });
                    nameTEController.clear();
                    idTEController.clear();
                    fieldTEController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Add'))
            ],
          );
        });
  }
}

class Student {
  final String name;
  final String id;
  final String field;
  final String uniqueId;

  Student({
    required this.name,
    required this.id,
    required this.field,
    required this.uniqueId,
  });
}
