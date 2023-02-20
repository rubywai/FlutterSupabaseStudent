import 'package:flutter/material.dart';
import 'package:supabase_test/student/data/student_repository.dart';

import '../data/student_model.dart';

class StudentDetailScreen extends StatefulWidget {
  const StudentDetailScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  final StudentRepository _studentRepository = StudentRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Detail'),
      ),
      body: FutureBuilder<Student>(
        future: _studentRepository.getStudent(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Student? student = snapshot.data;
            return (student == null)
                ? const Center(
                    child: Text('Student Not fount'),
                  )
                : Card(
                  child: Column(
                      children: [
                        ListTile(
                          title: const Text('Name:'),
                          trailing: Text(student.name),
                        ),
                        ListTile(
                          title: const Text('Age:'),
                          trailing: Text(student.age.toString()),
                        ),
                        ListTile(
                          title: const Text('Address:'),
                          trailing: Text(student.address),
                        )
                      ],
                    ),
                );
          } else if (snapshot.hasError) {}
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
