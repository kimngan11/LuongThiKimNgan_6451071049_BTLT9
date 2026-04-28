import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'bai1/views/task_home_view.dart';
import 'bai2/views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài tập LTUDTTBDD - Buổi 9',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainMenu(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Bài Tập Buổi 9"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sinh viên: Lương Thị Kim Ngân\nMSSV: 6451071049",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              icon: const Icon(Icons.list_alt),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TaskHomeView()));
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(280, 60),
                textStyle: const TextStyle(fontSize: 18),
              ),
              label: const Text("Bài 1: To-do List (Firestore)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.login),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()));
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(280, 60),
                textStyle: const TextStyle(fontSize: 18),
              ),
              label: const Text("Bài 2: Login/Register (Auth)"),
            ),
          ],
        ),
      ),
    );
  }
}
