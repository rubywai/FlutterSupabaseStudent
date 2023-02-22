import 'package:flutter/material.dart';
import 'package:supabase_test/common/dialog.dart';
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
  bool _isDeleting = false;
  String _status = '';

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
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                onPressed: () async{
                                bool isDelete = await  confirmDialog(context);
                                if(isDelete){
                                  _deleteStudent(student.id!);
                                }
                            }, child: const Text('Delete')),
                            ElevatedButton(onPressed: (){

                            }, child: const Text('Update'))
                          ],
                        ),
                        const Divider(),
                        if(_isDeleting)
                        const CircularProgressIndicator(),
                        const Divider(),
                        Text(_status)
                      ],
                    ),
                );
          } else if (snapshot.hasError) {}
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
  void _deleteStudent(int id)async{
    setState(() {
      _status = "Deleting student";
      _isDeleting = true;
    });
    try {
      await _studentRepository.deleteStudent(id);
      _status = "Successfully Deleted";
    }
    catch(e){
      _status = "Delete Failed";
    }
    finally{
      setState(() {
        _isDeleting = false;
      });
      await Future.delayed(const Duration(seconds: 1));
      _back();
    }
  }
  void _back(){
    Navigator.pop(context);
  }
}
