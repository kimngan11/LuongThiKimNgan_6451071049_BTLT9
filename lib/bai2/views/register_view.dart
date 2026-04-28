import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'auth_home_view.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final AuthController _authController = AuthController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _register() async {
    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng nhập đầy đủ email và mật khẩu.")),
      );
      return;
    }
    setState(() => _isLoading = true);
    try {
      await _authController.signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (!mounted) return;
      // Đăng ký thành công thì tự động chuyển sang trang Home (AuthHomeView)
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AuthHomeView()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi đăng ký: ${e.toString().replaceAll('Exception: ', '')}")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đăng ký tài khoản")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sinh viên: Lương Thị Kim Ngân\nMSSV: 6451071049",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Mật khẩu", border: OutlineInputBorder()),
            ),
            SizedBox(height: 24),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _register,
                    child: Text("Tạo tài khoản", style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                  ),
          ],
        ),
      ),
    );
  }
}
