import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_provider/model/todo_model.dart';
import 'package:todo_app_provider/provider/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

enum TodoListFilter { all, active, completed }

final todoListFilter = StateProvider<TodoListFilter>((ref) => TodoListFilter.all);

final todoListProvider = StateNotifierProvider<TodoListManager, List<Todo>>((ref) {
  return TodoListManager([
    Todo(id: const Uuid().v4(), desc: 'go to gym'),
    Todo(id: const Uuid().v4(), desc: 'shopping'),
    Todo(id: const Uuid().v4(), desc: 'do homework'),
    Todo(id: const Uuid().v4(), desc: 'watch tv'),
  ]);
});

final filteredTodoListProvider = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.all:
      return todoList;
    case TodoListFilter.active:
      return todoList.where((element) => !element.isCompleted).toList();
    case TodoListFilter.completed:
      return todoList.where((element) => element.isCompleted).toList();
  }
});

final uncompletedTodoCount = Provider<int>((ref) {
  final allTodos = ref.watch(todoListProvider);
  final count = allTodos.where((element) => !element.isCompleted).length;
  return count;
});

final currentTodoProvider = Provider<Todo>((ref) {
  throw UnimplementedError();
});
