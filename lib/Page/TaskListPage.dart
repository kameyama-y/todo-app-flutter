import 'package:flutter/material.dart';

// タスクのデータモデル
class Task {
  String title;
  bool isDone;

  Task(this.title, {this.isDone = false});
}

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  // タスクリスト（タイトルと完了状態を持つ）
  final List<Task> taskList = [Task("朝会"), Task("Flutter 勉強"), Task("日報")];

  // 新規タスク追加用
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      taskList.add(Task(_controller.text.trim()));
      _controller.clear();
    });
  }

  void _removeTask(int index) {
    setState(() {
      taskList.removeAt(index);
    });
  }

  void _toggleTask(int index, bool? value) {
    setState(() {
      taskList[index].isDone = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("タスク一覧"), centerTitle: true),
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
                      onChanged: (value) => _toggleTask(index, value),
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
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeTask(index),
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
