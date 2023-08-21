import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_provider/provider/app_providers.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  final void Function(DismissDirection direction) onDismissed;
  const TodoListItemWidget({super.key, required this.onDismissed});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  late FocusNode _textFocusNode;
  late TextEditingController _textController;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _textFocusNode = FocusNode();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todo = ref.watch(currentTodoProvider);
    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.horizontal,
      onDismissed: widget.onDismissed,
      child: Focus(
        onFocusChange: (value) {
          if (!value) {
            setState(() {});
            _hasFocus = false;
            ref.read(todoListProvider.notifier).edit(id: todo.id, newDesc: _textController.text);
          }
        },
        child: ListTile(
          onTap: () {
            setState(() {});
            _hasFocus = true;
            _textController.text = todo.desc;
            _textFocusNode.requestFocus();
          },
          contentPadding: EdgeInsets.zero,
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (value) {
              ref.read(todoListProvider.notifier).toggle(todo.id);
            },
          ),
          title: !_hasFocus
              ? Text(todo.desc)
              : TextField(
                  controller: _textController,
                  focusNode: _textFocusNode,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
        ),
      ),
    );
  }
}
