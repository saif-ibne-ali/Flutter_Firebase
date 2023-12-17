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
          child: const Icon(Icons.add),
          onPressed: () {
            studentCollectionRef.add({
              'name': 'Zahid',
              'id': '17151079',
              'field': 'CSE',
            });
          }),
      body: RefreshIndicator(
        onRefresh: getStudentData,
        child: StreamBuilder(
            stream: studentCollectionRef.snapshots(),
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
                      field: element.get('field'));
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
                        subtitle: Text(studentList[index].id),
                        trailing: Text(studentList[index].field),
                      );
                    });
              }
              return const SizedBox();
            }),
      ),
    );
  }
}

class Student {
  final String name;
  final String id;
  final String field;

  Student({required this.name, required this.id, required this.field});
}
