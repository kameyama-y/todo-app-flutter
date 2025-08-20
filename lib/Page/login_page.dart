import 'package:flutter/material.dart';
import '../Widget/InputField.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "ログイン",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),

                  // メールアドレス
                  InputField(label: 'メールアドレス'),
                  const SizedBox(height: 16),

                  // パスワード
                  InputField(label: "パスワード", obscureText: true),
                  const SizedBox(height: 24),

                  // ログインボタン
                  FractionallySizedBox(
                    widthFactor: 0.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, //背景
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ), // 高さを少し大きく
                      ),
                      onPressed: () {
                        // 認証処理を後で追加
                      },
                      child: const Text(
                        "ログイン",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),

              // 新規登録リンク
              TextButton(
                onPressed: () {
                  // 後で新規登録ページへ遷移
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
