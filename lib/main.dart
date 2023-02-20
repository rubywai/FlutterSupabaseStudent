import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_test/student/screen/student_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
      url: 'https://mibqngtsomagzlmubnuy.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1pYnFuZ3Rzb21hZ3psbXVibnV5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzYzOTA4MjYsImV4cCI6MTk5MTk2NjgyNn0.LBMW5LPkL0IItvjFvmEPGP4OKhyi2Bn8ujzx6wwtz_o');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: StudentScreen(),
    );
  }
}

