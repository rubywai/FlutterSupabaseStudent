import 'package:flutter/material.dart';
import 'package:supabase_test/student/screen/add_screen.dart';
import 'package:supabase_test/student/data/student_repository.dart';
import 'package:supabase_test/student/screen/student_detail_screen.dart';

import '../data/student_model.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final StudentRepository _repository = StudentRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supabase Lesson'),
      actions: [
        IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => AddStudent()));
        }, icon: Icon(Icons.add))
      ],),
      body: StreamBuilder<List<Student>>(
        stream: _repository.getAllStudent(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<Student> students = snapshot.data ?? [];
            return ListView.builder(
                itemCount: students.length,
                itemBuilder: (context,index){
                  Student student = students[index];
                  return InkWell(
                    onTap: (){
                      if(student.id != null) {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (_) => StudentDetailScreen(id: student.id!)));
                      }
                    },
                    child: Card(
                      child: Column(children: [
                        Text('Name : ${student.name}'),
                        const Divider(),
                        Text('Age : ${student.age}'),
                        const Divider(),
                        Text('Address : ${student.address}'),
                      ],),
                    ),
                  );
                });
          }
          else if(snapshot.hasError){
            return const Center(child: Text('Something wrong'),);
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      )
    );
  }
}
