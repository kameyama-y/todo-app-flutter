import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// プロフィール状態
class ProfileState {
  final String name;
  final int? age;
  final String gender;

  ProfileState({this.name = '', this.age, this.gender = '未設定'});

  ProfileState copyWith({String? name, int? age, String? gender}) {
    return ProfileState(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() => {'name': name, 'age': age, 'gender': gender};
}

/// StateNotifier でプロフィール管理
class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(ProfileState()) {
    loadProfile();
  }

  final supabase = Supabase.instance.client;

  /// Supabase から読み込み
  Future<void> loadProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final res = await supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (res != null) {
      state = state.copyWith(
        name: res['name'] ?? '',
        age: res['age'],
        gender: res['gender'] ?? '未設定',
      );
    }
  }

  /// プロフィール更新（画面から呼ぶ）
  Future<void> updateProfile({
    required String name,
    required int? age,
    required String gender,
  }) async {
    state = state.copyWith(name: name, age: age, gender: gender);

    final user = supabase.auth.currentUser;
    if (user == null) return;

    // Supabase に保存
    await supabase.from('profiles').upsert({
      'id': user.id,
      'name': name,
      'age': age,
      'gender': gender,
    });
  }
}

/// Provider
final profileNotifierProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
      return ProfileNotifier();
    });
