import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_provider/provider/app_providers.dart';
import 'package:todo_app_provider/widget/text_field_widget.dart';
import 'package:todo_app_provider/widget/title_widget.dart';
import 'package:todo_app_provider/widget/todo_list_item_widget.dart';
import 'package:todo_app_provider/widget/toolbar_widget.dart';

class TodoAppView extends ConsumerWidget {
  TodoAppView({super.key});
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var todoList = ref.watch(filteredTodoListProvider);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          const SizedBox(height: 20),
          TextFieldWidget(
            controller: textController,
            onSubmitted: (value) => ref.read(todoListProvider.notifier).addTodo(value ?? 'N/A'),
          ),
          const SizedBox(height: 20),
          ToolbarWidget(),
          todoList.isEmpty ? const Center(child: Text('Empty')) : const SizedBox.shrink(),
          for (var element in todoList)
            ProviderScope(
              overrides: [currentTodoProvider.overrideWithValue(element)],
              child: TodoListItemWidget(
                onDismissed: (_) {
                  ref.read(todoListProvider.notifier).remove(element.id);
                },
              ),
            )
        ],
      ),
    );
  }
}
