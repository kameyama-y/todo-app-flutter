import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Profile_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  String gender = "未設定";
  bool initialized = false; // 初期値セット済みかどうか

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    ageController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileNotifierProvider);

    // Controller にセット
    if (!initialized && profile.name.isNotEmpty) {
      nameController.text = profile.name;
      ageController.text = profile.age?.toString() ?? "";
      gender = profile.gender;
      initialized = true;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("ユーザー情報")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "名前"),
              onChanged: (value) {
                // 入力中に State を更新
                ref.read(profileNotifierProvider.notifier).state = ref
                    .read(profileNotifierProvider.notifier)
                    .state
                    .copyWith(name: value);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "年齢"),
              onChanged: (value) {
                // 入力中に State を更新
                ref.read(profileNotifierProvider.notifier).state = ref
                    .read(profileNotifierProvider.notifier)
                    .state
                    .copyWith(age: int.tryParse(value));
              },
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: gender,
              items: [
                "未設定",
                "男性",
                "女性",
                "その他",
              ].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => gender = value); // UI の更新
                  ref.read(profileNotifierProvider.notifier).state = ref
                      .read(profileNotifierProvider.notifier)
                      .state
                      .copyWith(gender: value);
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await ref
                    .read(profileNotifierProvider.notifier)
                    .updateProfile(
                      name: nameController.text,
                      age: int.tryParse(ageController.text),
                      gender: gender,
                    );
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("プロフィールを更新しました")));
              },
              child: const Text("更新する"),
            ),
          ],
        ),
      ),
    );
  }
}
