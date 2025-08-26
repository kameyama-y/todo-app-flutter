import 'package:flutter_riverpod/flutter_riverpod.dart';

// タスクのデータモデル
class Task {
  String title;
  bool isDone;

  Task(this.title, {this.isDone = false});
}

// タスクを管理する StateNotifier
class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([Task("朝会"), Task("Flutter 勉強"), Task("日報")]);

  //追加
  void addTask(String title) {
    if (title.trim().isEmpty) return;
    state = [...state, Task(title)];
  }

  //削除
  void removeTask(int index) {
    final newList = [...state]..removeAt(index);
    state = newList;
  }

  //チェックボックス
  void toggleTask(int index, bool? value) {
    final newList = [...state];
    newList[index].isDone = value ?? false;
    state = newList;
  }

  //編集
  void editTask(int index, String newTitle) {
    if (newTitle.trim().isEmpty) return;
    final newList = [...state];
    newList[index].title = newTitle.trim();
    state = newList;
  }
}

// Provider
final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
