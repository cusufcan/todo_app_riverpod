import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_provider/model/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<Todo>> {
  TodoListManager([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(String desc) {
    var todo = Todo(id: const Uuid().v4(), desc: desc);
    state = [...state, todo];
  }

  void toggle(String id) {
    state = [
      for (var todo in state) todo.id == id ? Todo(id: todo.id, desc: todo.desc, isCompleted: !todo.isCompleted) : todo
    ];
  }

  void edit({required String id, required String newDesc}) {
    state = [
      for (var todo in state) todo.id == id ? Todo(id: todo.id, desc: newDesc, isCompleted: todo.isCompleted) : todo
    ];
  }

  void remove(String id) {
    state = state.where((element) => element.id != id).toList();
  }
}
