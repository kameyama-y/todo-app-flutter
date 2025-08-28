import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final loginStateProvider = StateNotifierProvider<LoginStateNotifier, bool>((
  ref,
) {
  return LoginStateNotifier();
});

class LoginStateNotifier extends StateNotifier<bool> {
  LoginStateNotifier() : super(false) {
    _checkSession();
  }

  // 起動時にSupabaseのセッションをチェック
  void _checkSession() {
    final session = Supabase.instance.client.auth.currentSession;
    state = session != null;
  }

  // ログイン
  Future<void> login(String email, String password) async {
    final response = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user != null) {
      state = true;
    } else {
      state = false;
    }
  }

  // ログアウト
  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
    state = false;
  }
}
