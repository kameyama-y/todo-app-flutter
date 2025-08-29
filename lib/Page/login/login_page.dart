import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_app_flutter/Page/Signup/signup_page.dart';
import 'package:todo_app_flutter/Page/Task/TaskListPage.dart';

import 'package:todo_app_flutter/Page/login/login_state_provider.dart';
import 'package:todo_app_flutter/Widget/InputField.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ログイン状態の変化を監視して画面遷移
    ref.listen<bool>(loginStateProvider, (previous, next) {
      if (next) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TaskListPage()),
        );
      }
    });
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "ログイン",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              // メールアドレス
              InputField(label: 'メールアドレス', controller: emailController),
              const SizedBox(height: 16),
              // パスワード
              InputField(
                label: "パスワード",
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 24),
              // ログインボタン
              FractionallySizedBox(
                widthFactor: 0.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () async {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    await ref
                        .read(loginStateProvider.notifier)
                        .login(email, password);
                  },
                  child: const Text(
                    "ログイン",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 新規登録リンク
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: const Text("アカウントを作成する"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
