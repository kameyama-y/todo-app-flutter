import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Widget/edit_task_button.dart';
import '../Profile/ProfilePage.dart';
import '../login/login_state_provider.dart';
import 'task_provider.dart';

class TaskListPage extends ConsumerStatefulWidget {
  const TaskListPage({super.key});

  @override
  ConsumerState<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends ConsumerState<TaskListPage> {
  // 新規タスク追加用
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Supabase から初期データ取得
    Future.microtask(() => ref.read(taskProvider.notifier).fetchTasks());
  }

  //追加処理
  void _addTask() {
    ref.read(taskProvider.notifier).addTask(_controller.text.trim());
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final taskList = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("タスク一覧"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: "ユーザー情報",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 入力フォーム
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "タスクを入力",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _addTask, child: const Text("追加")),
              ],
            ),
          ),

          // タスク一覧
          Expanded(
            child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                final task = taskList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isDone,
                      onChanged: (value) => ref
                          .read(taskProvider.notifier)
                          .toggleTask(index, value),
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: task.isDone ? Colors.grey : Colors.black,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //編集ボタン
                        EditTaskButton(
                          index: index,
                          currentTitle: task.title,
                          isDone: task.isDone,
                        ),
                        //削除ボタン
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              ref.read(taskProvider.notifier).removeTask(index),
                          // ref.read(loginStateProvider.notifier).logout(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
