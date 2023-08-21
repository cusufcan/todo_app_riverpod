// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_provider/provider/app_providers.dart';

class ToolbarWidget extends ConsumerWidget {
  ToolbarWidget({super.key});
  var _currentFilter = TodoListFilter.all;

  Color changeTextColor(TodoListFilter filter) {
    return _currentFilter == filter ? Colors.orange : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unCompletedTodoCount = ref.watch(uncompletedTodoCount);
    _currentFilter = ref.watch(todoListFilter);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          unCompletedTodoCount == 0 ? 'All is well.' : '$unCompletedTodoCount uncompleted.',
          overflow: TextOverflow.ellipsis,
        )),
        Tooltip(
          message: 'All Todos',
          child: TextButton(
            style: TextButton.styleFrom(foregroundColor: changeTextColor(TodoListFilter.all)),
            onPressed: () => ref.read(todoListFilter.notifier).state = TodoListFilter.all,
            child: const Text('All'),
          ),
        ),
        Tooltip(
          message: 'Only Uncompleted Todos',
          child: TextButton(
              style: TextButton.styleFrom(foregroundColor: changeTextColor(TodoListFilter.active)),
              onPressed: () => ref.read(todoListFilter.notifier).state = TodoListFilter.active,
              child: const Text('Active')),
        ),
        Tooltip(
          message: 'Onyl Completed Todos',
          child: TextButton(
              style: TextButton.styleFrom(foregroundColor: changeTextColor(TodoListFilter.completed)),
              onPressed: () => ref.read(todoListFilter.notifier).state = TodoListFilter.completed,
              child: const Text('Completed')),
        ),
      ],
    );
  }
}
