import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_flutter/Page/Signup/signup_provider.dart';
import '../../Widget/InputField.dart';
import '../Task/TaskListPage.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(signUpStateProvider, (previous, next) {
      if (next) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TaskListPage()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "新規登録",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              InputField(label: "メールアドレス", controller: emailController),
              const SizedBox(height: 16),

              InputField(
                label: "パスワード",
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 16),

              InputField(
                label: "パスワード（確認）",
                controller: confirmPasswordController,
                obscureText: true,
              ),
              const SizedBox(height: 24),

              FractionallySizedBox(
                widthFactor: 0.5,
                child: ElevatedButton(
                  onPressed: () async {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final confirmPassword = confirmPasswordController.text
                        .trim();

                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("パスワードが一致しません")),
                      );
                      return;
                    }

                    await ref
                        .read(signUpStateProvider.notifier)
                        .signUp(email, password);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "登録する",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("ログイン画面へ戻る"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
