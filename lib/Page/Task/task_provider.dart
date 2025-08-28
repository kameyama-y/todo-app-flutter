import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// タスクのデータモデル
class Task {
  final int id;
  final String title;
  final bool isDone;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.isDone,
    required this.createdAt,
  });

  factory Task.fromMap(Map<String, dynamic> map) => Task(
    id: map['id'],
    title: map['text'],
    isDone: map['is_done'] ?? false,
    createdAt: DateTime.parse(map['created_at']),
  );
}

// タスクを管理する StateNotifier
class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  final supabase = Supabase.instance.client;

  //取得
  Future<void> fetchTasks() async {
    try {
      final response = await supabase
          .from('todos')
          .select()
          .order('created_at', ascending: false)
          .execute();

      if (response.data == null) {
        print('Error fetching tasks: response.data is null');
        return;
      }

      final data = response.data as List<dynamic>;
      state = data.map((e) => Task.fromMap(e)).toList();
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  //追加
  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) return;

    try {
      // Supabaseに追加
      final response = await supabase.from('todos').insert({
        'text': title,
        'is_done': false,
        'created_at': DateTime.now().toIso8601String(),
      }).select();

      if (response == null || response.isEmpty) {
        print('Error adding task: response is empty');
        return;
      }

      final data = response as List<dynamic>;
      final newTask = Task.fromMap(data[0]);
      state = [newTask, ...state]; // 新しいタスクを先頭に追加
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  //削除
  Future<void> removeTask(int index) async {
    final task = state[index];
    try {
      // 削除
      final response = await supabase
          .from('todos')
          .delete()
          .eq('id', task.id)
          .select();

      if (response == null || response.isEmpty) {
        print('Error adding task: response is empty');
        return;
      }

      final newList = [...state]..removeAt(index);
      state = newList;
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  //チェックボックス
  Future<void> toggleTask(int index, bool? value) async {
    final task = state[index];
    try {
      // 更新
      final response = await supabase
          .from('todos')
          .update({'is_done': value})
          .eq('id', task.id)
          .select();

      if (response == null || response.isEmpty) {
        print('Error adding task: response is empty');
        return;
      }

      final updatedData = response.first as Map<String, dynamic>;
      final updatedTask = Task.fromMap(updatedData);

      // stateのリストをコピーして該当要素を置き換え
      final newList = [...state];
      newList[index] = updatedTask;
      state = newList;
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  //編集
  Future<void> editTask(int index, String newTitle) async {
    if (newTitle.trim().isEmpty) return;
    final task = state[index];
    try {
      // 更新
      final response = await supabase
          .from('todos')
          .update({'text': newTitle.trim()})
          .eq('id', task.id)
          .select();

      if (response == null || response.isEmpty) {
        print('Error adding task: response is empty');
        return;
      }

      final updatedData = response.first as Map<String, dynamic>;
      final updatedTask = Task.fromMap(updatedData);

      // stateのリストをコピーして該当要素を置き換え
      final newList = [...state];
      newList[index] = updatedTask;
      state = newList;
    } catch (e) {
      print('Error adding task: $e');
    }
  }
}

// Provider
final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
