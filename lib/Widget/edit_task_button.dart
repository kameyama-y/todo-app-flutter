import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Page/Task/task_provider.dart';

class EditTaskButton extends ConsumerWidget {
  final int index;
  final String currentTitle;
  final bool isDone;

  const EditTaskButton({
    super.key,
    required this.index,
    required this.currentTitle,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(Icons.edit, color: isDone ? Colors.grey : Colors.blue),
      onPressed: isDone
          ? null
          : () async {
              final newTitle = await showDialog<String>(
                context: context,
                builder: (context) {
                  final controller = TextEditingController(text: currentTitle);
                  return AlertDialog(
                    title: const Text("タスクを編集"),
                    content: TextField(controller: controller),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("キャンセル"),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.pop(context, controller.text),
                        child: const Text("保存"),
                      ),
                    ],
                  );
                },
              );
              if (newTitle != null) {
                ref.read(taskProvider.notifier).editTask(index, newTitle);
              }
            },
    );
  }
}
