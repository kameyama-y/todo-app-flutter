import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final loginStateProvider = StateNotifierProvider<LoginStateNotifier, bool?>((
  ref,
) {
  return LoginStateNotifier();
});

class LoginStateNotifier extends StateNotifier<bool?> {
  LoginStateNotifier() : super(null) {
    _loadLoginState();
  }

  void _loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('isLoggedIn') ?? false;
  }

  void login() async {
    state = true;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  void logout() async {
    state = false;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }
}
