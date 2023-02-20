import 'package:flutter/material.dart';
import 'package:supabase_test/student/data/student_model.dart';
import 'package:supabase_test/student/data/student_repository.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final StudentRepository _studentRepository = StudentRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isLoading = false;
  String _status = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name *'),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age *'),
            ),
            TextField(

              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address *'),
            ),
            ElevatedButton(onPressed: () {
              String name = _nameController.text.trim();
              String age = _ageController.text.trim();
              String address = _addressController.text.trim();
              if(name.isNotEmpty && age.isNotEmpty && address.isNotEmpty){
                int ageInt = int.parse(age);
                setState(() {
                  _isLoading = true;
                  _status = "Uploading,...";
                });
                Student student = Student(null, name, ageInt, address);
                _studentRepository.addStudent(student)
                 .then((value){
                   _nameController.clear();
                   _ageController.clear();
                   _addressController.clear();
                   _status = "Successfully uploaded";
                }).catchError((e){
                  _status = 'Upload failed!';
                })
                .whenComplete(() {
                  setState(() {
                    _isLoading = false;
                  });
                });
              }
              else{
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Plese Enter completely')));
              }

            }, child: const Text('Add student')),
            const Divider(),
            if(_isLoading)
            const CircularProgressIndicator(),
            Divider(),
            Text(_status)
          ],
        ),
      ),
    );
  }
}
