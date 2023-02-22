import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_test/student/data/student_model.dart';

class StudentRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Stream<List<Student>> getAllStudent() {
    final students =
        _client.from('student').stream(primaryKey: ['id']).map((event) {
      return event.map((e) {
        return Student.fromJson(e);
      }).toList();
    });
    return students;
  }

  Future<void> addStudent(Student student) async {
    await _client.from('student').insert(student);
  }

  Future<Student> getStudent(int id) async {
    final student = await _client
        .from('student')
        .select()
        .eq('id', id) //where
        .single();
    return Student.fromJson(student);
  }

  Future deleteStudent(int id) async {
    return await _client.from('student').delete().eq('id', id);
  }

  Future updateStudent(Student student) async {
    return await _client.from('table').update({
      'id': student.id,
      'age': student.age,
      'name': student.name,
      'address': student.address
    });
  }
}
