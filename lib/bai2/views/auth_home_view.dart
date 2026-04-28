import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/auth_controller.dart';
import 'login_view.dart';

class AuthHomeView extends StatelessWidget {
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Trang chủ"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authController.signOut();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sinh viên: Lương Thị Kim Ngân\nMSSV: 6451071049",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 30),
            Icon(Icons.check_circle, color: Colors.green, size: 80),
            SizedBox(height: 16),
            Text(
              "Đăng nhập thành công!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Xin chào",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              icon: Icon(Icons.logout),
              label: Text("Đăng xuất"),
              onPressed: () async {
                await _authController.signOut();
                if (!context.mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
