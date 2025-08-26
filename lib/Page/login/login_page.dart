import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_app_flutter/Page/signup_page.dart';
import 'package:todo_app_flutter/Page/Task/TaskListPage.dart';

import 'package:todo_app_flutter/Page/login/login_state_provider.dart';
import 'package:todo_app_flutter/Widget/InputField.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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
                    backgroundColor: Colors.blueAccent, //背景
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ), // 高さを少し大きく
                  ),
                  onPressed: () {
                    // 認証処理を後で追加

                    //ログイン処理
                    ref.read(loginStateProvider.notifier).login();
                    print(
                      'loginStateProvider = ${ref.read(loginStateProvider)}',
                    );

                    // 一旦遷移
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TaskListPage()),
                    );
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
                  // 新規登録ページへ遷移
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
