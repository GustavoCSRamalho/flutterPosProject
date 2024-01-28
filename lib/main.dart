import 'package:flutter/material.dart';
import 'package:gerenciador_de_massa/mock/mock_students.dart';
import 'package:gerenciador_de_massa/models/student.dart';
import 'package:gerenciador_de_massa/providers/student/student_provider.dart';
import 'package:gerenciador_de_massa/providers/student/students_history_provider.dart';
import 'package:gerenciador_de_massa/screens/student/home_insert_screen.dart';
import 'package:gerenciador_de_massa/screens/student/home_screen.dart';
import 'package:gerenciador_de_massa/screens/student/student_history_insert_screen.dart';
import 'package:gerenciador_de_massa/screens/student/student_screen.dart';
import 'package:gerenciador_de_massa/screens/student/students_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'routes/route_paths.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final List<Student> _students = MOCK_STUDENTS;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StudentsProvider>(
            create: (context) => StudentsProvider()),
        ChangeNotifierProvider<StudentsHistoryProvider>(
            create: (context) => StudentsHistoryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter Demo",
        theme: ThemeData(primarySwatch: Colors.green),
        routes: {
          RoutePaths.HomeScreen: (context) => const HomeScreen(),
          RoutePaths.StudentInsertScreen: (context) =>
              const StudentInsertScreen(),
          RoutePaths.StudentsListScreen: (context) => StudentsListScreen(
                students: _students,
              ),
          RoutePaths.StudentScreen: (context) => const StudentScreen(),
          RoutePaths.StudentHistoryInsertScreen: (context) =>
              StudentHistorytInsertScreen(),
        },
      ),
    );
  }
}
