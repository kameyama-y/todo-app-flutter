import 'package:flutter/material.dart';
import '../Widget/InputField.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // タイトル
              const Text(
                "新規登録",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              // 名前
              InputField(label: "ユーザー名"),
              const SizedBox(height: 16),

              // メールアドレス
              InputField(label: "メールアドレス"),
              const SizedBox(height: 16),

              // パスワード
              InputField(label: "パスワード", obscureText: true),
              const SizedBox(height: 16),

              // パスワード確認
              InputField(label: "パスワード（確認）"),
              const SizedBox(height: 24),

              // 登録ボタン
              FractionallySizedBox(
                widthFactor: 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    // 登録処理
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

              // ログインページに戻る
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
