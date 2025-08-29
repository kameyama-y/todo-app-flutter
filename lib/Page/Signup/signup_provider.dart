import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupNotifier extends StateNotifier<bool> {
  SignupNotifier() : super(false);

  final supabase = Supabase.instance.client;

  Future<void> signUp(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // 成功
        state = true;
      } else {
        state = false;
        print("確認メールをチェックしてください");
      }
    } on AuthException catch (e) {
      print("Signup error: ${e.message}");
      state = false;
    } catch (e) {
      print("Unexpected error: $e");
      state = false;
    }
  }
}

final signUpStateProvider = StateNotifierProvider<SignupNotifier, bool>((ref) {
  return SignupNotifier();
});
